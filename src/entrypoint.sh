#!/bin/bash

parse_inputs() {
  mdformat_file_or_dir=""
  if [ "${INPUT_MDFORMAT_FILE_OR_DIR}" != "" ] || [ "${INPUT_MDFORMAT_FILE_OR_DIR}" != "." ]; then
    mdformat_file_or_dir="${INPUT_MDFORMAT_FILE_OR_DIR}"
  fi

  mdformat_number=''
  if [ "${INPUT_MDFORMAT_NUMBER}" == "1" ] || [ "${INPUT_MDFORMAT_NUMBER}" == "true" ]; then
    mdformat_number="--number"
  fi

  mdformat_wrap=''
  if [ -n "${INPUT_MDFORMAT_WRAP}" ]; then
    mdformat_wrap="--wrap ${INPUT_MDFORMAT_WRAP}"
  fi

  mdformat_end_of_line=''
  if [ -n "${INPUT_MDFORMAT_END_OF_LINE}" ]; then
    mdformat_end_of_line="--end-of-line ${INPUT_MDFORMAT_END_OF_LINE}"
  fi
}

mdformat() {
  # gather output
  echo "lint: info: mdformat on ${mdformat_file_or_dir}."
  lint_output=$(mdformat ${mdformat_number} "${mdformat_wrap} ${mdformat_end_of_line} ${mdformat_file_or_dir}")
  lint_exit_code=${?}

  # exit code 0 - success
  if [ ${lint_exit_code} -eq 0 ]; then
    echo "lint: info: successful mdformat on ${mdformat_file_or_dir}."
    echo "${lint_output}"
    echo
  fi

  # exit code !0 - failure
  if [ ${lint_exit_code} -ne 0 ]; then
    echo "lint: error: failed mdformat on ${mdformat_file_or_dir}."
    echo "${lint_output}"
    echo
  fi

  echo ::set-output name=mdformat_output::"${lint_output}"
  exit ${lint_exit_code}
}

main() {
  parse_inputs
  mdformat
}

main "${*}"
