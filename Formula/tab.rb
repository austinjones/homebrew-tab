class Tab < Formula
  desc "The intuitive, config-driven terminal multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/v0.3.7.tar.gz"
  sha256 "8c7cbe91b27d75c93572bf587906487b7b3f0fd3007b7c3023747555bccae02e"
  license "MIT"
  head "https://github.com/austinjones/tab-rs.git"

  bottle do
    root_url "https://github.com/austinjones/tab-rs/releases/download/v0.3.7"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "76a7c3ad2dffa026ece869015da083cbaf5c0f7938e9ff8c829a964d4730cc2f" => :catalina
  end

  depends_on "rust" => :build

  uses_from_macos "zlib"

  def install
    system "cargo", "install", "--path", "tab/", "--locked", "--root", prefix

    bash_output = Utils.safe_popen_read("#{bin}/tab", "--completion", "bash")
    (bash_completion/"tab").write bash_output

    zsh_output = Utils.safe_popen_read("#{bin}/tab", "--completion", "zsh")
    (zsh_completion/"_tab").write zsh_output

    fish_output = Utils.safe_popen_read("#{bin}/tab", "--completion", "fish")
    (fish_completion/"tab.fish").write fish_output
  end

  test do
    # TODO: add some kind of test assertion that is compatible with the automated bump script
    # assert_equal "tab 0.3.2\n", shell_output("#{bin}/tab -V")
  end
end
