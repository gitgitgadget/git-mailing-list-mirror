Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110171F859
	for <e@80x24.org>; Sun, 28 Aug 2016 12:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755464AbcH1MlQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 08:41:16 -0400
Received: from mout.web.de ([212.227.15.14]:63851 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755359AbcH1MlO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 08:41:14 -0400
Received: from [192.168.178.36] ([79.237.54.155]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MAvZs-1bnvXT02bc-009usb; Sun, 28 Aug 2016 14:39:31
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] p3400: make test script executable
Message-ID: <9d882519-12dd-e854-9303-66df5532b67f@web.de>
Date:   Sun, 28 Aug 2016 14:39:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:5V/aUoir/tvV4o2aewY06sH6wapxxZ+bLzyQCLV+S5ct+t4oGJy
 jT9pKwOK86vKkV2fEtcWAll4fXtXX/ITAuboc51PezMGJAkmBv3MYK2X1pW8Mgn8QiOLRB7
 iZfyyhbHsaSqyLjLHNjL+pKecIehsi7zLDX77HN3hs6yFFxbThs/1TM1YcOtfZnJ047C++0
 7b8l8deJk2xUDTsqYkCmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aFDjIuTxJfs=:tAdJZt6G8OgNY5eqFc/ecX
 QfR7MTWt8yFd6f2T0+eXRluo6s5dJu2KXmhzU0Magk41SbbVG0ZxlV0fT529r2Wp/atva94wJ
 fgE0mfW/gyy6aXouWktZvIL/XEqZOUmAduz+h6lL0zZwzPkqoWKtjv+ljPtmwDzQ98JqcoWZC
 iam1igS4yvmLRrnt0xQjSDp0IyBCIc/Q5MV0Ffr7huA08Iexn7uJf32z0yWJbuMgmBc/pGjpB
 wAeS9oI+wURroY6lnNUI3JTmrsxHCc1XmP+5I08mR58kTobPv2HsvdFa3bLSLN4BxUf1te7jR
 w2HvRWGBDoxGg7NM2ihRTagUPS4nYVG0v8IxZ2pmmIVKRoG4zz553BIDTjA8iDDKBi2ekCvGB
 YbMTyMiT+kWktErYE19xI3b2eDLhAa4NYlD7TwynPn7Y7NUB05nr/Z+EWwuTxXfN3qc6H7exV
 fXupHhN4mf45iUaxKYgt1TuReMIet+gnG1fTWG9eLuPXDekrQaw+7yW4/4vaASofpjil5Gi0r
 oI4g14k7F3jNJOoCX+GU+MyJXwDAr1Kcmqaon+G+qemDKl9gOHkhsBKFx4nGciXqVyAODmUWI
 IY5mzkPA/OCjo+kdNWgniBikzqbTg/mCmFaruaORra5bO1D36IHXgbr0MoH7BS/48vzYs1wpV
 Cy2ofvg9nuqh+VSNJ/wDS9gun4E22AaRscaA2qwYZ5t9FlKPlGPa+Im2By6NaI9N+D2MYDJ15
 /ndrojIrSeNuLwnk716xrxbiTg2I66yF+WpfXhMAmN/7ch/+Ol7DCOZbUic03MoT2gHrtt3Cu
 0+s2Agi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This script was added by v2.10.0-rc0~3^2.

 t/perf/p3400-rebase.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/perf/p3400-rebase.sh

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
old mode 100644
new mode 100755
-- 
2.9.3

