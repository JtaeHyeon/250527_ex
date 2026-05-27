# DESIGN.md — Glacier 디자인 시스템

> **North Star: "Frozen Light"**
> 겹쳐진 반투명 레이어를 통한 신비로운 깊이감. 어둡고, 분위기 있고, 프리미엄한 느낌.

---

## 색상 팔레트

| 역할               | 변수명 (권장)         | 값          | 설명                            |
|--------------------|-----------------------|-------------|---------------------------------|
| Primary (Ice Blue) | `--color-primary`     | `#7dd3fc`   | 인터랙티브 요소, 액센트         |
| Background         | `--color-bg`          | `#0a0e1a`   | 베이스 배경 (짙은 네이비-블랙)  |
| Tertiary (Lavender)| `--color-tertiary`    | `#c8a0f0`   | 보조 액센트, 강조 요소          |
| On Surface         | `--color-on-surface`  | `#e2e8f0`   | 주 본문 텍스트                  |
| On Surface Variant | `--color-on-surface-variant` | `#94a3b8` | 보조 텍스트, 레이블          |

> **원칙:** 모든 표면 컨테이너는 틴트된 유리 레이어처럼 느껴져야 한다.

---

## 글래스 효과 (핵심 패턴)

글래스모피즘은 이 디자인 시스템의 가장 중요한 시각적 패턴입니다.
**모든 떠 있는(floating) 요소에는 반드시 글래스 효과를 적용해야 합니다.**

### 기본 글래스 카드 / 패널

```css
background: rgba(15, 21, 36, 0.6);
backdrop-filter: blur(16px);
-webkit-backdrop-filter: blur(16px);
border: 1px solid rgba(125, 211, 252, 0.1);
```

### 상위(Elevated) 글래스

```css
background: rgba(15, 21, 36, 0.75);
backdrop-filter: blur(24px);
-webkit-backdrop-filter: blur(24px);
border: 1px solid rgba(125, 211, 252, 0.15);
```

### 테두리 원칙

- 항상 반투명 처리: primary 색상 또는 흰색의 **8~15% 불투명도**를 사용한다.
- 테두리는 구조적이지 않고 **발광하는(luminous)** 느낌이어야 한다.

---

## 타이포그래피

| 구분       | 폰트   | 굵기      | 기타              |
|------------|--------|-----------|-------------------|
| 헤드라인   | Inter  | Semibold (600) | 자간 살짝 넓게  |
| 본문       | Inter  | Regular (400)  | 기본 자간        |
| 보조 텍스트| Inter  | Regular (400)  | `on_surface_variant` 색상 |

```css
/* Google Fonts 임포트 */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap');

body {
  font-family: 'Inter', sans-serif;
  color: var(--color-on-surface);
}
```

---

## 엘리베이션 (깊이 표현)

그림자 대신 **블러 강도와 불투명도**로 깊이를 표현합니다.

| 레이어    | 불투명도 | 블러    | 용도                     |
|-----------|----------|---------|--------------------------|
| Layer 0   | 100%     | 없음    | 고체 배경 (베이스)       |
| Layer 1   | 60%      | 16px    | 일반 카드, 패널          |
| Layer 2   | 75%      | 24px    | 모달, 드롭다운 등 상위 요소 |

### 글로우 효과

인터랙티브 상태에만 제한적으로 사용합니다.

```css
/* 기본 글로우 (카드 hover 등) */
box-shadow: 0 0 30px rgba(125, 211, 252, 0.05);

/* 강조 글로우 (버튼 focus, 입력 focus 등) */
box-shadow: 0 0 20px rgba(125, 211, 252, 0.2);
```

---

## 컴포넌트 가이드

### 버튼

```css
/* Primary 버튼 */
.btn-primary {
  background: rgba(125, 211, 252, 0.15);
  border: 1px solid rgba(125, 211, 252, 0.3);
  color: #7dd3fc;
  backdrop-filter: blur(8px);
  transition: background 0.2s ease, box-shadow 0.2s ease;
}

.btn-primary:hover {
  background: rgba(125, 211, 252, 0.25);
  box-shadow: 0 0 20px rgba(125, 211, 252, 0.2);
}
```

### 카드

```css
.card {
  background: rgba(15, 21, 36, 0.6);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid rgba(125, 211, 252, 0.1);
  border-radius: 12px;
}
```

### 입력 필드 (Input)

```css
.input {
  background: rgba(15, 21, 36, 0.5);
  border: 1px solid rgba(125, 211, 252, 0.12);
  color: var(--color-on-surface);
  backdrop-filter: blur(8px);
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.input:focus {
  border-color: rgba(125, 211, 252, 0.4);
  box-shadow: 0 0 20px rgba(125, 211, 252, 0.15);
  outline: none;
}
```

---

## 디자인 원칙 요약

1. **불투명 배경 금지** — 떠 있는(floating) 요소에는 절대 불투명 단색 배경을 사용하지 않는다.
2. **테두리는 발광하게** — 구조적인 테두리가 아닌, 미묘하게 빛나는 느낌을 유지한다.
3. **글로우는 인터랙티브 상태 전용** — 기본 상태에서 글로우를 남용하지 않는다.
4. **깊이는 블러로** — 그림자 대신 `backdrop-filter`와 불투명도로 레이어 깊이를 표현한다.
5. **폰트는 Inter 단일** — 일관된 현대적 가독성을 위해 Inter만 사용한다.
