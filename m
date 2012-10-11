From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v2 2/8] Shorten two over-long lines in git-bisect-lk2009.txt
 by removing some white-space
Date: Thu, 11 Oct 2012 19:18:01 +0200 (CEST)
Message-ID: <1813304588.46882.1349975881205.JavaMail.ngmail@webmail22.arcor-online.net>
References: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 19:18:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMMOl-0006vm-7d
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759038Ab2JKRSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:18:05 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:52739 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759031Ab2JKRSC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 13:18:02 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id 487E15AE46;
	Thu, 11 Oct 2012 19:18:01 +0200 (CEST)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net [151.189.21.57])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 3EE387FF45B;
	Thu, 11 Oct 2012 19:18:01 +0200 (CEST)
Received: from webmail22.arcor-online.net (webmail22.arcor-online.net [151.189.8.137])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 322E5CC5F0;
	Thu, 11 Oct 2012 19:18:01 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-17.arcor-online.net 322E5CC5F0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349975881; bh=UgirkkrTWbn3PWzgfeblzZz2OywjeeRKVZ2RmPjgGV0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=k5gpOAQ6OnrzLHG+vNkli2MsQA6cr5y8YL7uoR218NWqKW4LtQb8JOeH2Q14YuyLG
	 liE5YIRAR4V/eza5VVvEGoHICopICbmAsakcPRlvxtuQDYb48P+hnxCSGP4aoWz4bo
	 pX7cmpaR6fmICH876LqLQdIHhLE9I9oWhzdauqiY=
Received: from [188.105.106.236] by webmail22.arcor-online.net (151.189.8.137) with HTTP (Arcor Webmail); Thu, 11 Oct 2012 19:18:00 +0200 (CEST)
In-Reply-To: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.236
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207492>

>From e7c97695b676e1ebe66491b3ed256051b9a3b4f1 Mon Sep 17 00:00:00 2001
From: Thomas Ackermann <th.acker@arcor.de>
Date: Thu, 4 Oct 2012 19:11:43 +0200
Subject: [PATCH] Shorten two over-long lines in git-bisect-lk2009.txt by
 removing some white-space

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/git-bisect-lk2009.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 8a2ba37..80745d7 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -257,7 +257,7 @@ Date:   Sat May 3 11:59:44 2008 -0700
 
     Linux 2.6.26-rc1
 
-:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
+:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M  Makefile
 -------------
 
 At this point we can see what the commit does, check it out (if it's
@@ -331,7 +331,7 @@ Date:   Sat May 3 11:59:44 2008 -0700
 
     Linux 2.6.26-rc1
 
-:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
+:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M  Makefile
 bisect run success
 -------------
 
-- 
1.7.11.msysgit.1


---
Thomas
