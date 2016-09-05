require 'timeout'

class UriResponseWorker
  include Sidekiq::Worker
  def perform(id, link_text)
    if link = Link.find_by(id: id)
      uri = URI.parse(link_text)
      begin
        response_code = Timeout::timeout(5) { Net::HTTP.get_response(uri).code }
        logger.info "Response: #{id} - #{response_code} - #{link_text}"
        case response_code&.chars&.first
        when '2'
          good_response(link, response_code, id, link_text)
        when '3'
          good_response(link, response_code, id, link_text)
        else
          bad_response(link, response_code, id, link_text)
        end
      rescue Timeout::Error
        bad_response(link, 'Timeout', id, link_text)
      rescue Errno::ECONNREFUSED
        bad_response(link, 'Connection Refused', id, link_text)
      end
    end
  end

  def good_response(link, response_code, id, link_text)
    unless link.is_good?
      logger.info "Link was bad: #{id} - #{response_code} - #{link_text}"
      ActionCable.server.broadcast 'alert_channel',
        status: 'Good link! (Link was bad!)',
        response_code: response_code,
        link: link_text,
        timestamp: "#{Time.zone.now}"
      link.update_attribute(:is_good, true)
    end
    UriResponseWorker.perform_in(60.seconds, id, link_text)
  end

  def bad_response(link, response_code, id, link_text)
    if link.is_good?
      logger.info "Link was good: #{id} - #{response_code} - #{link_text}"
      ActionCable.server.broadcast 'alert_channel',
        status: 'Bad link! (Link was good!)',
        response_code: response_code,
        link: link_text,
        timestamp: "#{Time.zone.now}"
      link.update_attribute(:is_good, false)
    end
    UriResponseWorker.perform_in(30.seconds, id, link_text)
  end
end
