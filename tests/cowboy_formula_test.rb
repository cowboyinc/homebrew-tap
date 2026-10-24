# Evaluate the real formula DSL without installing an unreleased toolset.
class Formula
  class << self
    attr_reader :test_block
    def resources; @resources ||= []; end
    def desc(*); end
    def homepage(*); end
    def version(value = nil); @version = value if value; @version; end
    def license(*); end
    def url(*); end
    def sha256(*); end
    def on_macos(&block); class_eval(&block); end
    def on_linux(&block); class_eval(&block); end
    def on_arm(&block); class_eval(&block); end
    def on_intel(&block); class_eval(&block); end
    def resource(name, &block); resources << name; class_eval(&block) if block; end
    def test(&block); @test_block = block; end
  end
  class Bin
    attr_reader :installed
    def install(*names); @installed = names; end
    def /(name); "/formula/bin/#{name}"; end
    def to_s; '/formula/bin'; end
  end
  def bin; @bin ||= Bin.new; end
  def commands; @commands ||= []; end
  def version; self.class.version; end
  def generate_completions_from_executable(*); end
  def shell_output(command); commands << command; "cowboy cbfs #{version} _cowboy"; end
  def assert_match(expected, actual); raise "missing #{expected}" unless actual.include?(expected.to_s); end
  def assert_predicate(*); end
end
load File.expand_path('../Formula/cowboy.rb', __dir__)
raise 'standalone CBFS resource remains' if Cowboy.resources.include?('cbfs')
formula = Cowboy.new
formula.install
raise 'archive must install exactly the core toolset' unless formula.bin.installed == %w[cowboy cowboy-dev-runner lasso]
formula.instance_eval(&Cowboy.test_block)
raise 'embedded CBFS is not tested' unless formula.commands.include?('/formula/bin/cowboy cbfs --help')
raise 'standalone CBFS command remains' if formula.commands.any? { |command| command.start_with?('/formula/bin/cbfs ') }
puts 'Formula embedded CBFS and toolset contract passed'
