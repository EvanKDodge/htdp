;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1_19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (string-insert str i)

  (if (or (> i (string-length str)) (< i 0))
      "i must be >= 0 and <= the length of str"
      (string-append (substring str 0 i)
                     "_"
                     (substring str i (string-length str)))))