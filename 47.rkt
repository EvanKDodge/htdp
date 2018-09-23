;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |47|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; happiness guage (call it guage-prog)
; guage-prog consumes maximum level of happiness
; guage starts w/max score
; with each clock tick, happiness decreases by 0.1
; happiness never falls below 0
; pressing the down key increases happiness by 1/5
; pressing the up key increases happiness by 1/3
; solid red rectangle
; happiness of 0 - rectangle is gone
; happiness of 100 - rectangle fills the scene

(define RECT_W 200)
(define RECT_H (* RECT_W .2))
(define OL_GAP 4)



(define RECT (underlay
  (rectangle (+ RECT_W OL_GAP) (+ RECT_H OL_GAP) "solid" "black")
  (rectangle RECT_W RECT_H "solid" "red")))