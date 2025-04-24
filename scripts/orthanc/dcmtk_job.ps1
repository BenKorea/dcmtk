# 변수를 선언
$AETLocal="NMTEMPSERVER"; $AETRemote="ORTHANC"; $DicomHost="127.0.0.1"; $Port=4242; $DateRange="20250102-20250202"; $Modality="PT"

# echoscu 테스트 (NMTEMPSERVER → ORTHANC:4242)
echoscu -v -aet $AETLocal -aec $AETRemote $DicomHost $Port

# echoscu 테스트 (ORTHANC → NMTEMPSERVER:5681)
echoscu -v -aet $AETRemote -aec $AETLocal $DicomHost 5681

# C-STORE 테스트를 위한 DICOM 파일 경로 설정
$DcmFilePath="C:\Projects\dcmtk\scripts\orthanc\test.dcm"

# C-STORE 테스트 (NMTEMPSERVER → ORTHANC:4242)
storescu -v -aet $AETLocal -aec $AETRemote $DicomHost $Port $DcmFilePath

# C-STORE 테스트 (ORTHANC → NMTEMPSERVER:5681)
storescu -v -aet $AETRemote -aec $AETLocal $DicomHost 5681 $DcmFilePath

# C-FIND 테스트 (NMTEMPSERVER → ORTHANC:4242)
findscu -v -d -S -aet $AETLocal -aec $AETRemote $DicomHost 4242 -k QueryRetrieveLevel=STUDY -k StudyDate=$DateRange
