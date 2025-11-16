# Homebrew Formula for RustyYOLO
# This formula should be placed in a separate tap repository: brooksomics/homebrew-rustyolo
# Usage: brew install brooksomics/rustyolo/rustyolo

class Rustyolo < Formula
  desc "Secure, firewalled wrapper for running AI agents in YOLO mode"
  homepage "https://github.com/brooksomics/llm-rustyolo"
  version "0.3.0"  # Update this when creating new releases
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v0.2.0/rustyolo-x86_64-apple-darwin.tar.gz"
      sha256 "cb6d6c3cdd67d6e8c0851d7834458d452c6a2132f83b686c6ed99906ca60cf7d"  # Calculate with: shasum -a 256 rustyolo-x86_64-apple-darwin.tar.gz
    elsif Hardware::CPU.arm?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v0.2.0/rustyolo-aarch64-apple-darwin.tar.gz"
      sha256 "6338a814cf00f486cdb4be739e0627a574534e59d80f8d769f64b33986b988d3"  # Calculate with: shasum -a 256 rustyolo-aarch64-apple-darwin.tar.gz
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v0.2.0/rustyolo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "sha256:f1d712c327987194c6271e0408cfa88e480bec2063d0816232252e109afed1a5"  # Calculate with: shasum -a 256 rustyolo-x86_64-unknown-linux-gnu.tar.gz
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
