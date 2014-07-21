require 'spec_helper'

describe MtgSearchParser::Lexer do
  it "lexes a word" do
    expect(subject.lex("word")).to eq(["word"])
  end

  it "splits two words" do
    expect(subject.lex("word foo")).to eq(["word", "foo"])
  end

  it "keeps characters in words" do
    expect(subject.lex("foo-bar cat")).to eq(["foo-bar", "cat"])
  end

  it "allows apostrophes" do
    expect(subject.lex("foo's bar")).to eq(["foo's", "bar"])
  end

  it "keeps : in the word" do
    expect(subject.lex("foo:bar cat")).to eq(["foo:bar", "cat"])
  end

  it "keeps ! in the word" do
    expect(subject.lex("foo!bar cat")).to eq(["foo!bar", "cat"])
  end

  it "keeps it all together if the word starts with a bang" do
    expect(subject.lex("!foo bar baz")).to eq(["!foo bar baz"])
  end

  it "keeps tokens together with quotes" do
    expect(subject.lex('"foo bar" baz')).to eq(['"foo bar"', 'baz'])
  end

  it "allows quotes in the middle of the term" do
    expect(subject.lex('o:"foo bar" baz')).to eq(['o:"foo bar"', 'baz'])
  end
end
