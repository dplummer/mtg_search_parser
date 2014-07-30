require 'spec_helper'

module MtgSearchParser
  describe Lexer do
    it "lexes a word" do
      expect(subject.lex("word")).to eq([Nodes::Query.new("word")])
    end

    it "splits two words" do
      expect(subject.lex("word foo")).
        to eq([Nodes::Query.new("word"), Nodes::Query.new("foo")])
    end

    it "keeps characters in words" do
      expect(subject.lex("foo-bar cat")).
        to eq([Nodes::Query.new("foo-bar"), Nodes::Query.new("cat")])
    end

    it "allows apostrophes" do
      expect(subject.lex("foo's bar")).
        to eq([Nodes::Query.new("foo's"), Nodes::Query.new("bar")])
    end

    it "keeps : in the word" do
      expect(subject.lex("foo:bar cat")).
        to eq([Nodes::Query.new("foo:bar"), Nodes::Query.new("cat")])
    end

    it "keeps ! in the word" do
      expect(subject.lex("foo!bar cat")).
        to eq([Nodes::Query.new("foo!bar"), Nodes::Query.new("cat")])
    end

    it "keeps it all together if the word starts with a bang" do
      expect(subject.lex("!foo bar baz")).
        to eq([Nodes::Query.new("!foo bar baz")])
    end

    it "keeps tokens together with quotes" do
      expect(subject.lex('"foo bar" baz')).
        to eq([Nodes::Query.new('"foo bar"'), Nodes::Query.new("baz")])
    end

    it "allows quotes in the middle of the term" do
      expect(subject.lex('o:"foo bar" baz')).
        to eq([Nodes::Query.new('o:"foo bar"'), Nodes::Query.new("baz")])
    end

    it "recognizes left and right parens" do
      expect(subject.lex("(foo)")).
        to eq([Nodes::LeftParen.new, Nodes::Query.new("foo"), Nodes::RightParen.new])
    end

    it "recognizes left and right parens ignoring spaces" do
      expect(subject.lex(" ( foo ) ")).
        to eq([Nodes::LeftParen.new, Nodes::Query.new("foo"), Nodes::RightParen.new])
    end

    it "parses AND as an AndNode" do
      expect(subject.lex("foo AND bar")).
        to eq([Nodes::Query.new("foo"), Nodes::And.new, Nodes::Query.new("bar")])
    end

    it "parses and as an AndNode" do
      expect(subject.lex("foo and bar")).
        to eq([Nodes::Query.new("foo"), Nodes::And.new, Nodes::Query.new("bar")])
    end

    it "parses OR as an OrNode" do
      expect(subject.lex("foo OR bar")).
        to eq([Nodes::Query.new("foo"), Nodes::Or.new, Nodes::Query.new("bar")])
    end

    it "parses or as an OrNode" do
      expect(subject.lex("foo or bar")).
        to eq([Nodes::Query.new("foo"), Nodes::Or.new, Nodes::Query.new("bar")])
    end

    it "parses NOT as an NotNode" do
      expect(subject.lex("foo NOT bar")).
        to eq([Nodes::Query.new("foo"), Nodes::Not.new, Nodes::Query.new("bar")])
    end

    it "parses not as an NotNode" do
      expect(subject.lex("foo not bar")).
        to eq([Nodes::Query.new("foo"), Nodes::Not.new, Nodes::Query.new("bar")])
    end
  end
end
