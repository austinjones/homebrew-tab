class Tab < Formula
  desc "The intuitive, config-driven terminal multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/v0.5.3.tar.gz"
  sha256 "ddebb3998b8b003f6f07affe68a780f4e0cdccc3d95408c736703b0121727f53"
  license "MIT"
  head "https://github.com/austinjones/tab-rs.git"
  # rebuild

  bottle do
    root_url "https://github.com/austinjones/tab-rs/releases/download/v0.5.2"
    cellar :any_skip_relocation
    sha256 "3bf4b63c137f9673cdb1d07f862f4c65eb5556486a3b12211813003a96a5dd01" => :catalina
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
