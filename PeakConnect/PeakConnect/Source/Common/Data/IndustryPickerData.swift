import Foundation

struct Industry: Hashable {
    let name: String
}

struct IndustryCategory: Hashable {
    let name: String
    let industries: [Industry]
}

struct IndustryPickerData {
    static let categories: [IndustryCategory] = [
        IndustryCategory(name: "제조 및 산업", industries: [
            Industry(name: "자동차"),
            Industry(name: "전자/전기"),
            Industry(name: "반도체"),
            Industry(name: "기계"),
            Industry(name: "화학"),
            Industry(name: "석유/에너지"),
            Industry(name: "철강/금속"),
            Industry(name: "조선/항공"),
            Industry(name: "건설/플랜트")
        ]),
        IndustryCategory(name: "서비스업", industries: [
            Industry(name: "IT/소프트웨어"),
            Industry(name: "클라우드/데이터"),
            Industry(name: "광고/마케팅"),
            Industry(name: "교육/에듀테크"),
            Industry(name: "물류/유통"),
            Industry(name: "헬스케어/의료"),
            Industry(name: "컨설팅"),
            Industry(name: "법률/회계"),
            Industry(name: "여행/관광")
        ]),
        IndustryCategory(name: "금융", industries: [
            Industry(name: "은행"),
            Industry(name: "보험"),
            Industry(name: "증권"),
            Industry(name: "핀테크")
        ]),
        IndustryCategory(name: "유통 및 소비재", industries: [
            Industry(name: "패션/의류"),
            Industry(name: "화장품/뷰티"),
            Industry(name: "식음료"),
            Industry(name: "프랜차이즈"),
            Industry(name: "전자상거래")
        ]),
        IndustryCategory(name: "통신 및 미디어", industries: [
            Industry(name: "통신"),
            Industry(name: "방송"),
            Industry(name: "미디어/콘텐츠"),
            Industry(name: "게임/엔터테인먼트"),
            Industry(name: "출판")
        ]),
        IndustryCategory(name: "공공 및 기타", industries: [
            Industry(name: "공공기관"),
            Industry(name: "비영리단체"),
            Industry(name: "교육기관"),
            Industry(name: "연구소")
        ])
    ]
}
