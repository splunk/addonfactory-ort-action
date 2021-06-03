#!/usr/bin/env bash
#   ########################################################################
#   Copyright 2021 Splunk Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#   ######################################################################## export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

echo ::group::analyzer
rm -rf /github/workspace/$INPUT_WORKDIR/.ort/analyzer  || true
rm -rf /github/workspace/$INPUT_WORKDIR/.ort/reports  || true
/opt/ort/bin/ort --info analyze -f JSON -i /github/workspace/$INPUT_WORKDIR/ -o /github/workspace/$INPUT_WORKDIR/.ort/analyzer/
exitCode=$?

echo "::endgroup::"

echo ::group::reports

/opt/ort/bin/ort \
    report -f Excel,SpdxDocument,AsciiDocTemplate,NoticeTemplate \
    --ort-file=/workspace/$INPUT_WORKDIR/.ort/analyzer/analyzer-result.json \
    -o /github/workspace/$INPUT_WORKDIR/.ort/reports
/opt/ort/bin/ort \
    report -f NoticeTemplate \
    --ort-file=/workspace/$INPUT_WORKDIR/.ort/analyzer/analyzer-result.json -O NoticeTemplate=template.id=summary\
    -o /github/workspace/$INPUT_WORKDIR/.ort/reports
    
echo "::endgroup::"

exit $exitCode