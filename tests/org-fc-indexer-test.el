(require 'org-fc)
(require 'org-fc-test-helper)
(require 'ert)

(ert-deftest org-fc-test-index-malformed ()
  (let ((files
         '("malformed/no_review_data.org"
           "malformed/no_properties.org"
           "malformed/normal_swapped_drawers.org"
           "malformed/unclosed_drawer1.org"
           "malformed/unclosed_drawer2.org")))
    (dolist (file files)
      (org-fc-test-check-structure
       '((:cards ()))
       (org-fc-awk-index-paths (list (org-fc-test-fixture file)))))))

(ert-deftest org-fc-test-escaping ()
  (org-fc-test-check-structure
   '((:cards ((:id "33645f3a-384d-44ed-aed2-a2d56b973800"))))
   (org-fc-awk-index-paths
    (list (org-fc-test-fixture "escaping/spaces in filename.org")))))

(ert-deftest org-fc-test-index-keywords ()
  (org-fc-test-check-structure
   '((:title "File Title Uppercase"
      :cards ((:inherited-tags ":tag1:tag2:")))
     (:title "File Title Lowercase"
      :cards ((:inherited-tags ":tag3:tag4:"))))
   (org-fc-awk-index-paths
    (list (org-fc-test-fixture "index/uppercase.org")
          (org-fc-test-fixture "index/lowercase.org")))))

(ert-deftest org-fc-test-index ()
  (org-fc-test-check-structure
   '((:cards
      ((:id "edee8940-5c9a-4c70-b1c4-f45c194c0c97"
        :local-tags ":fc:tag1:"
        :title "Headline")
       (:id "59b3b102-aebd-44ba-a1fd-6dc912c34fcf"
        :local-tags ":fc:tag2:"
        :title "Headline 2")
       (:id "a7ed2686-73e6-4780-825d-78cf4b2e5374"
        :local-tags ":fc:tag3:"
        :title "Headline 3:not_a_tag:"))))
   (org-fc-awk-index (list (org-fc-test-fixture "index/test.org")))))
