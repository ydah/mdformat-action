#!/bin/bash

parse_inputs() {
  file_or_dir=""
  if [ "${INPUT_FILE_OR_DIR}" != "" ]; then
    file_or_dir="${INPUT_FILE_OR_DIR}"
  fi

  number=''
  if [ "${INPUT_NUMBER}" == "1" ] || [ "${INPUT_NUMBER}" == "true" ]; then
    number="--number"
  fi

  wrap=''
  if [ -n "${INPUT_WRAP}" ]; then
    wrap="--wrap ${INPUT_WRAP}"
  fi

  end_of_line=''
  if [ -n "${INPUT_END_OF_LINE}" ]; then
    end_of_line="--end-of-line ${INPUT_END_OF_LINE}"
  fi
}

run_mdformat() {
  echo "lint: info: mdformat on ${file_or_dir}."
  lint_output=$(mdformat --check ${number} ${wrap} ${end_of_line} ${file_or_dir})
  lint_exit_code=${?}

  if [ ${lint_exit_code} -eq 0 ]; then
    echo "lint: info: successful mdformat on ${file_or_dir}."
    echo "${lint_output}"
    echo
  fi

  if [ ${lint_exit_code} -ne 0 ]; then
    echo "lint: error: failed mdformat on ${file_or_dir}."
    mdformat ${number} ${wrap} ${end_of_line} ${file_or_dir}
    git diff
    echo
  fi

  echo ::set-output name=mdformat_output::"${lint_output}"
  exit ${lint_exit_code}
}

main() {
  parse_inputs
  run_mdformat
}

main "${*}"
