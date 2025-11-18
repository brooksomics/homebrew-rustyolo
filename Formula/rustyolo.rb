# Homebrew Formula for RustyYOLO
# This formula should be placed in a separate tap repository: brooksomics/homebrew-rustyolo
# Usage: brew install brooksomics/rustyolo/rustyolo

class Rustyolo < Formula
  desc "Secure, firewalled wrapper for running AI agents in YOLO mode"
  homepage "https://github.com/brooksomics/llm-rustyolo"
  version "0.4.0"  # Update this when creating new releases
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v#{version}/rustyolo-x86_64-apple-darwin.tar.gz"
      sha256 "b523929b80c089a88df4cce2fccf1aa28003262003e9420a16c08a90a20fa27e"  # Calculate with: shasum -a 256 rustyolo-x86_64-apple-darwin.tar.gz
    elsif Hardware::CPU.arm?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v#{version}/rustyolo-aarch64-apple-darwin.tar.gz"
      sha256 "bebdf25819f7faf50d49b54ab9c38f5f880f93513709e11b8768452bb3813b08"  # Calculate with: shasum -a 256 rustyolo-aarch64-apple-darwin.tar.gz
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v#{version}/rustyolo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c92539e43648424d16e96b4937c906573653e0b83bfe3efb366b6f7e6479dcc0"  # Calculate with: shasum -a 256 rustyolo-x86_64-unknown-linux-gnu.tar.gz
    end
  end

  # Dependencies
  depends_on "docker"

  def install
    bin.install "rustyolo"
  end

  def caveats
    <<~EOS
      RustyYOLO requires Docker to run AI agents in isolated containers.

      To get started:
        1. Ensure Docker is running
        2. Build the Docker image (first time only):
           cd #{opt_prefix} && docker build -t llm-rustyolo:latest .

      Or pull from a registry (if published):
           docker pull ghcr.io/brooksomics/llm-rustyolo:latest

      Usage:
        rustyolo --help
        rustyolo --allow-domains "github.com pypi.org" claude

      Update the CLI:
        brew upgrade rustyolo

      Update the Docker image:
        rustyolo update --image
    EOS
  end

  test do
    assert_match "rustyolo", shell_output("#{bin}/rustyolo --version")
  end
end
