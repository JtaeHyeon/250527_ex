#!/usr/bin/env bash
# =============================================================================
# commit.sh - git-commit 스킬 보조 스크립트
#
# 사용법:
#   ./scripts/commit.sh "<타입>" "<한글 설명>" [파일1] [파일2] ...
#
# 파일을 지정하지 않으면 모든 변경 파일(git add -A)을 스테이징합니다.
#
# 예시:
#   ./scripts/commit.sh "docs" "AGENTS.md 행동 지침 작성" AGENTS.md
#   ./scripts/commit.sh "asset" "SVG 에셋 파일 추가" cat.svg penguin_bike.svg
# =============================================================================

set -euo pipefail

TYPE="${1:-}"
MESSAGE="${2:-}"

# 인자 유효성 검사
if [[ -z "$TYPE" || -z "$MESSAGE" ]]; then
  echo "사용법: $0 <타입> <한글 설명> [파일...]" >&2
  echo "예시:   $0 docs 'AGENTS.md 초안 작성' AGENTS.md" >&2
  exit 1
fi

# 허용된 커밋 타입 목록
VALID_TYPES=("feat" "fix" "docs" "style" "refactor" "test" "chore" "asset")
VALID=false
for t in "${VALID_TYPES[@]}"; do
  if [[ "$TYPE" == "$t" ]]; then
    VALID=true
    break
  fi
done

if [[ "$VALID" == false ]]; then
  echo "❌ 허용되지 않는 타입: '$TYPE'" >&2
  echo "   허용 타입: ${VALID_TYPES[*]}" >&2
  exit 1
fi

# 나머지 인자를 파일 목록으로 사용
shift 2
FILES=("$@")

# 스테이징
if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "📦 모든 변경 파일을 스테이징합니다..."
  git add -A
else
  echo "📦 지정 파일을 스테이징합니다: ${FILES[*]}"
  git add "${FILES[@]}"
fi

# 스테이징된 파일 확인
STAGED=$(git diff --cached --name-only)
if [[ -z "$STAGED" ]]; then
  echo "⚠️  스테이징된 변경 사항이 없습니다. 커밋을 건너뜁니다." >&2
  exit 0
fi

echo "📋 스테이징된 파일:"
echo "$STAGED" | sed 's/^/  - /'

# 커밋 실행
COMMIT_MSG="${TYPE}: ${MESSAGE}"
git commit -m "$COMMIT_MSG"

echo ""
echo "✅ 커밋 완료: $COMMIT_MSG"
