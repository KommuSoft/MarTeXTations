# MarTeXTations

Briding the creation of beautiful presentations and easy-to-make presentation with Markdown, TeX and [impress.js](https://github.com/bartaz/impress.js) (or at least try to).

## Concept

Write a presentation in *Markdown*, and compile it to its `.htm`, `.pdf`,... equivalent. The program makes use of [d3.js](https://github.com/mbostock/d3) and [d3plotter.js](https://github.com/KommuSoft/d3plotter).

## Installation

Run

    make install

## Usage

First one writes a presentation in Markdown. Slides are separated with horizontal lines (`---`). If the files is called `file.md`, run:

    make file.htm

to generate an `impress.js` presentation, or


     make file.pdf

to generate an LaTeX/beamer presentation.

## End-product

Is the result of the compiler considered to be an *end-product*? Not per se. The compiler outputs HTML or LaTeX which are open formats. In a next stage, one can thus modify the output and improve the result. The idea of this project is more to automate the generation of a first version.
