;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1_9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define in (square 50 "solid" "blue"))

(if (string? in)
    (string-length in)
    (if (image? in)
        (* (image-height in) (image-width in))
        (if (and (number? in) (<= in 0))
            in
            (if (number? in)
                (- in 1)
                (if in
                    10
                    20)))))