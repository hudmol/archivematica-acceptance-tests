@empty-dirs @dev
Feature: Empty directories are deleted from AIPs but documented and reconstructed as necessary.
  Users of Archivematica want to be able to submit digital content that
  contains empty directories and be assured that those empty directories are,
  in principle at least, still present since empty directories may have
  significance. However, the BagIt specification requires that empty
  directories be removed. Furthermore, the <mets:structMap TYPE="physical">
  must accurately reflect the contents of the AIP and therefore cannot document
  empty directories that have been moved. Archivematica should, therefore,
  document empty directories in a <mets:structMap TYPE="logical"> and
  reconstruct them as necessary, e.g., during re-ingest.

  @typical
  Scenario Outline: Gilgamesh wants to create an AIP from digital content with empty directories, see the empty directories documented in the METS file, reingest it, and still see the empty directories in the METS file.
    # Given that remote transfer content at <directory_path> contains an empty directory at <empty_directory_path>
    # And a default processing config that gets to the Store AIP decision point
    # When a transfer is initiated on directory <directory_path>
    # And the user waits for the "Store AIP (review)" decision point to appear during ingest
    Then <empty_directory_path> is not in the METS file's physical structMap
    And <empty_directory_path> is in the METS file's logical structMap
    When the user chooses "Store AIP" at decision point "Store AIP (review)" during ingest
    And the user waits for the AIP to appear in archival storage
    And the user downloads the AIP
    And the user decompresses the AIP

    Examples: transfer sources
    | empty_directory_path | directory_path                                                                                 |
    | dir2/dir2a/dir2aiii  | ~/archivematica-sampledata/TestTransfers/acceptance-tests/pid-binding/hierarchy-with-empty-dir |