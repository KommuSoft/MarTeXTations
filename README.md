# MarTeXTations

Briding the creation of beautiful presentations and easy-to-make presentation with Markdown, TeX and impress.js (or at least try to).

## Concept

Write a presentation in *Markdown*, and compile it to its `.htm`, `.pdf`,... equivalent.

## Installation

Run

    make install

## Usage

First one writes a presentation in Markdown. Slides are separated with horizontal lines (`---`). If the files is called `file.md`, run:

    make file.htm

to generate an `impress.js` presentation, or


     make file.pdf

to generate an LaTeX/beamer presentation.