"use strict";

var color = d3.scale.category20();
var width = 1024;
var height = 600;
var scale = d3.scale.pow().exponent(.7);

d3.json("/wordfreq/JERRY", function(error, json) {
    if (error) return console.warn(error);

    var data = Object.keys(json).map(function(v) {
        return {text: v, size: json[v]};
      });

    console.log(data);

    d3.layout.cloud().size([width, height])
      .words(data)
      .padding(2)
      .rotate(function() { return ~~(Math.random() * 2) * (Math.random() > 0.5 ? -1 : 1) * 45; })
      .font("Helvetica")
      .fontSize(function(d) { return scale(d.size); })
      .on("end", draw)
      .start();
});

function draw(words) {
    d3.select("#container").append("svg")
        .attr("width", width)
        .attr("height", height)
      .append("g")
        .attr("transform", "translate(" + width/2 + "," + height/2 + ")")
      .selectAll("text")
        .data(words)
      .enter().append("text")
        .style("font-size", function(d) { return d.size + "px"; })
        .style("font-family", "Helvetica")
        .style("fill", function(d, i) { return color(i); })
        .attr("text-anchor", "middle")
        .attr("transform", function(d) {
          return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
        })
        .text(function(d) { return d.text; });
}
