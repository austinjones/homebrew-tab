class Tab < Formula
  desc "The intuitive, config-driven terminal multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/v0.5.7.tar.gz"
  sha256 "07ad9383d54e292ee3565c4b07287d60fd7190a62835fa7a05ca50ae15fd4e60"
  license "MIT"
  head "https://github.com/austinjones/tab-rs.git"
  # rebuild

  bottle do
    root_url "https://github.com/austinjones/tab-rs/releases/download/v0.5.7"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "92568438f5e666ab2fa6bddb43cae37c6f93a8829bdd349cbea4d3cc4f985268"
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
