From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v2 3/8] Change headline of technical/send-pack-pipeline.txt
 to not confuse its content with content from git-send-pack.txt
Date: Thu, 11 Oct 2012 19:19:51 +0200 (CEST)
Message-ID: <1278494757.46927.1349975991144.JavaMail.ngmail@webmail22.arcor-online.net>
References: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 19:20:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMMQV-000899-To
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759050Ab2JKRTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:19:53 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:48097 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759031Ab2JKRTw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 13:19:52 -0400
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mx.arcor.de (Postfix) with ESMTP id 3371827383;
	Thu, 11 Oct 2012 19:19:51 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id 2A992834015;
	Thu, 11 Oct 2012 19:19:51 +0200 (CEST)
Received: from webmail22.arcor-online.net (webmail22.arcor-online.net [151.189.8.137])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 281E327383;
	Thu, 11 Oct 2012 19:19:51 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-12.arcor-online.net 281E327383
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349975991; bh=em3UoXo0LrzWY8BDpkO7o4z9ikf+AEfSyVnu8/wTclM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=D05Ag8ypTaRzUdyqq6/0WwcFCvwOeZ9W5s03YEFshrZC6bHyjJQElFaxmrM4Kc8Ss
	 nh0mnt6suRSB+kqncF5XQ7MAPYSiTKLHEa+aesIQ1Cgvkbvrs9G4qp2QmulV7Y1Jfl
	 Y2yaeeIQvHXSaLKsy941cStkrypDzx3HQNcaFJsk=
Received: from [188.105.106.236] by webmail22.arcor-online.net (151.189.8.137) with HTTP (Arcor Webmail); Thu, 11 Oct 2012 19:19:51 +0200 (CEST)
In-Reply-To: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.236
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207493>

>From af1f0dc8e02ef178fc89f5fa3893a997a4a9b2eb Mon Sep 17 00:00:00 2001
From: Thomas Ackermann <th.acker@arcor.de>
Date: Tue, 9 Oct 2012 20:19:34 +0200
Subject: [PATCH] Change headline of technical/send-pack-pipeline.txt to not
 confuse its content with content from git-send-pack.txt

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/send-pack-pipeline.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/send-pack-pipeline.txt b/Documentation/technical/send-pack-pipeline.txt
index 681efe4..9b5a0bc 100644
--- a/Documentation/technical/send-pack-pipeline.txt
+++ b/Documentation/technical/send-pack-pipeline.txt
@@ -1,5 +1,5 @@
-git-send-pack
-=============
+Git-send-pack internals
+=======================
 
 Overall operation
 -----------------
-- 
1.7.11.msysgit.1


---
Thomas
