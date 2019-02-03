*** Pozn. pre iOS Lead-a ***


Safearea guidelines - Snapkit:

if #available(iOS 11, *) {
	make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
} else {
	make.top.equalToSuperview()
}
