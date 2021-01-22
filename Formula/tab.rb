class Tab < Formula
  desc "The intuitive, config-driven terminal multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/v0.5.6.tar.gz"
  sha256 "5c13061f5f7ad73346749211e4719072caff2b709c766623fc62a43a07c05f90"
  license "MIT"
  head "https://github.com/austinjones/tab-rs.git"
  # rebuild

  bottle do
    root_url "https://github.com/austinjones/tab-rs/releases/download/v0.5.5"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "5edee2379a1baa5084d78358fbcfc9f660b03607849033c3a4a1f89bb0d18424" => :catalina
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
