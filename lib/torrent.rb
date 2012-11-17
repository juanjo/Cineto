require "rubygems"
# require "rubytorrent"

# TORRENT = "#{Rails.root}/tmp/playboy.torrent"
# TORRENT = "http://torcache.net/torrent/BCA636C7C9A1B3FC0A7D8414456A452577ADC1D3.torrent?title=[kat.ph]playboy.lingerie.december.2012.january.2013.azizex666"
# TORRENT = "http://torcache.net/torrent/CFD3BD074A638FDDF1DEFDE973854791DFE6FFA0.torrent"
# TORRENT = "http://torcache.net/torrent/BCA636C7C9A1B3FC0A7D8414456A452577ADC1D3.torrent"
# TORRENT = "http://releases.ubuntu.com/12.10/ubuntu-12.10-desktop-i386.iso.torrent"

TORRENT = "magnet:?xt=urn:btih:e07c4bebff79022c4c4c7e483188d10097d42ca7&dn=ubuntu-12.10-server-amd64.iso&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80"


require "transmission-client"

EventMachine.run do
  t = Transmission::Client.new('fernandoguillen.info', 9091, 'pepe', 'pepe')

  t.on_download_finished do |torrent|
    puts "XXXXXXXXXXXXXXXXXXXXXX1XXXXXXXXXXXXXXXXXXXXXX1Wha torrent finished"
  end
  t.on_torrent_stopped do |torrent|
    puts "XXXXXXXXXXXXXXXXXXXXXX1XXXXXXXXXXXXXXXXXXXXXX1Oooh torrent stopped"
  end
  t.on_torrent_started do |torrent|
    puts "XXXXXXXXXXXXXXXXXXXXXX1XXXXXXXXXXXXXXXXXXXXXX1Torrent started."
  end
  t.on_torrent_removed do |torrent|
    puts "XXXXXXXXXXXXXXXXXXXXXX1XXXXXXXXXXXXXXXXXXXXXX1Darn torrent deleted."
  end

  # EM.add_periodic_timer(100) do
  #   t.torrents do |torrents|
  #     puts "XXX: in loop.."
  #     torrents.each do |tor|
  #       puts tor.percentDone
  #     end
  #   end
  # end

  t.add_torrent("filename"=>"ubuntu-9.10-alternate-amd64.iso.torrent")

  puts "XXX: before while"
  while true
    puts "XXXXXXXXXXXXXXXXXXXXXX1"
    sleep(1)
    puts "XXXXXXXXXXXXXXXXXXXXXX2"
    puts "XXX: t: #{t.inspect}"

    t.torrents do |torrents|
      puts "XXX: in loop.."
      torrents.each do |tor|
        puts tor.percentDone
      end
    end
  end

end