Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 11459 invoked by uid 111); 28 Feb 2008 06:33:18 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 28 Feb 2008 01:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbYB1GdE (ORCPT <rfc822;peff@peff.net>);
	Thu, 28 Feb 2008 01:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbYB1GdE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 01:33:04 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:59451 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750735AbYB1GdD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 01:33:03 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id 9205090CE8;
	Wed, 27 Feb 2008 22:33:01 -0800 (PST)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH 2/3] Document the sendemail.smtpserverport config variable
Date:	Thu, 28 Feb 2008 01:32:58 -0500
Message-Id: <1204180379-21767-2-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.4.3.233.g52eaf
In-Reply-To: <1204180379-21767-1-git-send-email-kevin@sb.org>
References: <1204180379-21767-1-git-send-email-kevin@sb.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

---
 Documentation/git-send-email.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 336d797..9d0a10c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -216,6 +216,9 @@ sendemail.chainreplyto::
 sendemail.smtpserver::
 	Default SMTP server to use.
 
+sendemail.smtpserverport::
+	Default SMTP server port to use.
+
 sendemail.smtpuser::
 	Default SMTP-AUTH username.
 
-- 
1.5.4.3.233.g52eaf

