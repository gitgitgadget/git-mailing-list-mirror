From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] gittutorial.txt: remove reference to ancient Git version
Date: Tue, 11 Nov 2014 20:13:36 +0100 (CET)
Message-ID: <1409592246.526697.1415733216505.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 20:13:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoGsp-0001nR-K0
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 20:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbaKKTNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 14:13:39 -0500
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:35001 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751484AbaKKTNi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2014 14:13:38 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id 8D5AB8726;
	Tue, 11 Nov 2014 20:13:36 +0100 (CET)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 721407DACB6;
	Tue, 11 Nov 2014 20:13:36 +0100 (CET)
Received: from webmail12.arcor-online.net (webmail12.arcor-online.net [151.189.8.64])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 73A8BD8A01;
	Tue, 11 Nov 2014 20:13:36 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-03.arcor-online.net 73A8BD8A01
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1415733216; bh=SvPQ9eGENCwB3L3nw6rpJjiq3wy41PP2oHoMyRGSdMs=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=tsdnakf9kK4iP/Ua/zvcuE1jhNTYoMmlrAnTKqJDJpI1k2qWD/c9Y3m9SfwRQbd7u
	 fpdNKxI3neabq1anBn3puNhDQuA/9wSLw7ZS0e7p35mqDU2k4gB+EZn+qqr+rpA2Y9
	 6WGhpPTZTMvWAh2ETmxyJbyMs3KelCK3IqUPOVys=
Received: from [178.7.21.53] by webmail12.arcor-online.net (151.189.8.64) with HTTP (Arcor Webmail); Tue, 11 Nov 2014 20:13:36 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.21.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/gittutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index af9f709..710e636 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -3,7 +3,7 @@ gittutorial(7)
 
 NAME
 ----
-gittutorial - A tutorial introduction to Git (for version 1.5.1 or newer)
+gittutorial - A tutorial introduction to Git
 
 SYNOPSIS
 --------
-- 
1.9.4.msysgit.0
