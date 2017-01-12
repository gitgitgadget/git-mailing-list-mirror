Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0017C1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 21:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdALVdE (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 16:33:04 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64986 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdALVc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 16:32:57 -0500
Received: from localhost.localdomain ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id RmzJcW0LO0KuvRmzKcL1f0; Thu, 12 Jan 2017 21:32:50 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=xtxXYLxNAAAA:8 a=voM4FWlXAAAA:8
 a=tkN0JUJ3N53BWj1yxnwA:9 a=xts0dhWdiJbonKbuqhAr:22 a=IC2XNlieTeVoXbcui8wp:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 1/3] doc: gitk: remove gitview reference
Date:   Thu, 12 Jan 2017 21:32:38 +0000
Message-Id: <20170112213240.7972-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
In-Reply-To: <20170112213240.7972-1-philipoakley@iee.org>
References: <20170112213240.7972-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfDMPUe0FO9eqpM9+rMs3WMsv1sAJvn8qYrr59YiEnTP7MwvMnNbrL185BBhMhWXjf1s/kJ5qxM+kSkwRj9dvGt+8aEVmo5Jv2ETbxOxtbA2syBmDyKiq
 0d6POQV3jRXO4ad9q34ghh5jICr1aFFF3PZr3laIal3mWHpUnGUFIPlHuD7QzA5oiZl3Pe+mjkIuk6HiU9qvGzGlybLOO+3ttHjb0N6od1W8nLBGuVkC5aPR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

contrib/gitview has been removed. Remove the reference.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
cc: Paul Mackerras <paulus@ozlabs.org>
---
 Documentation/gitk.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index e382dd9..73c02b9 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -187,10 +187,6 @@ SEE ALSO
 'qgit(1)'::
 	A repository browser written in C++ using Qt.
 
-'gitview(1)'::
-	A repository browser written in Python using Gtk. It's based on
-	'bzrk(1)' and distributed in the contrib area of the Git repository.
-
 'tig(1)'::
 	A minimal repository browser and Git tool output highlighter written
 	in C using Ncurses.
-- 
2.9.0.windows.1.323.g0305acf

