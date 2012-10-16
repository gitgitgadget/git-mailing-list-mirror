From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v3 3/8] Change headline of technical/send-pack-pipeline.txt
 to not confuse its content with content from git-send-pack.txt
Date: Tue, 16 Oct 2012 19:23:08 +0200 (CEST)
Message-ID: <2041665885.154187.1350408188331.JavaMail.ngmail@webmail15.arcor-online.net>
References: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de, git@drmicha.warpmail.net
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:23:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOArS-0002X8-4g
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab2JPRXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:23:11 -0400
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:39914 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755135Ab2JPRXJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 13:23:09 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id 690999BF44;
	Tue, 16 Oct 2012 19:23:08 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 5F408212007;
	Tue, 16 Oct 2012 19:23:08 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 55A47133736;
	Tue, 16 Oct 2012 19:23:08 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 55A47133736
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1350408188; bh=Fu6FDL2v+3PP0yxrQlGd2mKl2cPxEbh1f2Da22K/uwY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=ubFj+wgpL770WAgydB0vJcJ6l5aYo/ZDewjlZsmmMpLpzJ//qGsOr7BTlyR7COKdC
	 l1LgiA0fx7HJkg39Yfy+3815gk2ga96sGx5giR/6Vra7ABgCSQ280sQWB0+/at0QSd
	 qfGKxTgTEMnZqzv6dflADxAA7SINE0fNfJkxk4fQ=
Received: from [188.98.243.159] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Tue, 16 Oct 2012 19:23:08 +0200 (CEST)
In-Reply-To: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.243.159
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207855>


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
