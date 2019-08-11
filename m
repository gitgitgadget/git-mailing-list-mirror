Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C684B1F731
	for <e@80x24.org>; Sun, 11 Aug 2019 15:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfHKPL5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 11:11:57 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:13514 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHKPL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 11:11:56 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Aug 2019 11:11:55 EDT
Received: from localhost.localdomain ([92.7.169.237])
        by smtp.talktalk.net with SMTP
        id wpNohrQ92niZTwpNohulLx; Sun, 11 Aug 2019 16:03:45 +0100
X-Originating-IP: [92.7.169.237]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=tcYJKHXJF8zWhnf8ZoLugA==:117
 a=tcYJKHXJF8zWhnf8ZoLugA==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=evINK-nbAAAA:8
 a=xtxXYLxNAAAA:8 a=AUd_NHdVAAAA:8 a=pGLkceISAAAA:8 a=iTTcatRJAAAA:8
 a=eNcD7ojaAAAA:8 a=mK_AVkanAAAA:8 a=L4Cqve91x0nJdpRknpcA:9
 a=hDTzM9o2CbMFtNBv:21 a=WdYWEJYSg13vOgQk:21 a=QEXdDO2ut3YA:10
 a=FOzlGPZX7ncA:10 a=afdim8hk4ZEA:10 a=RfR_gqz1fSpA9VikTjo0:22
 a=xts0dhWdiJbonKbuqhAr:22 a=IPzMlBXDSktj-FTXo0bc:22 a=rRYMMicksRHQPzyJ67jW:22
 a=3gWm3jAn84ENXaBijsEo:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] .mailmap: update email address of Philip Oakley
Date:   Sun, 11 Aug 2019 16:03:38 +0100
Message-Id: <20190811150338.1310-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.23.0.rc2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMhmonnx/zUdIxVOZKyIGcfvPTVC9wDXDJd5/MCr2QXtFS/Ve31bFRMJZ8P7vHau+2FqjBzv3NW2wm0XCqzdLSRf16avUdBCpZK52GqEzv4o3Y4bOH7+
 uKTSV5JWWFWxC36w3+H9ymXvsWdKgIIORJAMYb3qIISUbLme5A6w/qiK0YgCFaQdxBSUFYYF6AjXLF6TDtvFBy+9tOwhNJSYgw48wpH+HVUyOPOAepGlvxgP
 QkWmKqUtTYruD7ccxPLjt1r2lfDvyOBV3nLv4bDkzgs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My IEE 'home for life' email service is being withdrawn on 30 Sept 2019.
Replace with my new email domain.

I also have a secondary (backup) 'home for life' through
<philipoakley@dunelm.org.uk>.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 82cd0569d5..9a5ff04753 100644
--- a/.mailmap
+++ b/.mailmap
@@ -210,6 +210,7 @@ Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
 Petr Baudis <pasky@ucw.cz> <xpasky@machine>
 Phil Hord <hordp@cisco.com> <phil.hord@gmail.com>
 Philip Jägenstedt <philip@foolip.org> <philip.jagenstedt@gmail.com>
+Philip Oakley <philipoakley@iee.email> <philipoakley@iee.org> # secondary <philipoakley@dunelm.org.uk>
 Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
 Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
-- 
2.23.0.rc2.windows.1

