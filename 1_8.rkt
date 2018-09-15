;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1_8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define cat (square 10 "solid" "blue"))

(if
 (>= (image-height cat) (image-width cat))
 "tall"
 "wide")

(if
 (> (image-height cat) (image-width cat))
 "tall"
 (if
  (< (image-height cat) (image-width cat))
  "wide"
  "square"))