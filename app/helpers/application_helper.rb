# encoding: utf-8

module ApplicationHelper
  def torrent_stats(torrent)
    date = torrent.added_at.strftime("%Y-%m-%d %H:%M")
    percent = "%02.2f" % torrent.percent_done
    size = number_to_human_size(torrent.size)
    download_rate = number_to_human_size(torrent.rate_download)
    upload_rate = number_to_human_size(torrent.rate_upload)

    "#{size} #{date} #{percent}% ↓#{download_rate}/s ↑#{upload_rate}/s"
  end

  def torrent_file_stats(file)
    downloaded = number_to_human_size(file.bytes_completed)
    size = number_to_human_size(file.size)

    "#{downloaded} of #{size}"
  end

  def torrent_file_downloaded(file)
    file.bytes_completed == file.size
  end

  def twitterized_type(type)
    case type
      when :alert
        "alert alert-error"
      when :notice
        "alert alert-success"
      else
        type.to_s
    end
  end
end
