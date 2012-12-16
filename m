From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Remove misleading date form api-index-skel.txt
Date: Sun, 16 Dec 2012 09:42:49 +0100 (CET)
Message-ID: <38388978.118261.1355647369577.JavaMail.ngmail@webmail21.arcor-online.net>
References: <1582223824.296627.1355560147565.JavaMail.ngmail@webmail08.arcor-online.net> <1479174763.154268.1350408444997.JavaMail.ngmail@webmail15.arcor-online.net> <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 09:43:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk9of-00014G-JG
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 09:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684Ab2LPImv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 03:42:51 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:56484 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751190Ab2LPImv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Dec 2012 03:42:51 -0500
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mx.arcor.de (Postfix) with ESMTP id 910E8A9E14
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 09:42:49 +0100 (CET)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 918B914A602
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 09:42:49 +0100 (CET)
Received: from webmail21.arcor-online.net (webmail21.arcor-online.net [151.189.8.136])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 8A5701AB52D
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 09:42:49 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net 8A5701AB52D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1355647369; bh=Sww/LUbvUjWcFMwTXFnPWSiiingUHFW7TGga5ZzQd3s=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=ejCjZl7sFmDvlIQlMk+CadfAqW+Zz1KFHqgxPWccgK3nne1x44tVloANDVQhFZEq2
	 5uTglTSWEuKLTnasFQwFKliGiQztQ7K2rsk+jCtyYBN8AwqgEFH4l/r5TXThqSq9H9
	 GjZBiHHuBy3aRRiSBpRrGm9xb45opxAOZp3ES0lc=
Received: from [94.217.21.17] by webmail21.arcor-online.net (151.189.8.136) with HTTP (Arcor Webmail); Sun, 16 Dec 2012 09:42:49 +0100 (CET)
In-Reply-To: <1582223824.296627.1355560147565.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.21.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211585>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/api-index-skel.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/technical/api-index-skel.txt b/Documentation/technical/api-index-skel.txt
index af7cc2e..730cfac 100644
--- a/Documentation/technical/api-index-skel.txt
+++ b/Documentation/technical/api-index-skel.txt
@@ -11,5 +11,3 @@ documents them.
 ////////////////////////////////////////////////////////////////
 // table of contents end
 ////////////////////////////////////////////////////////////////
-
-2007-11-24
-- 
1.8.0.msysgit.0


---
Thomas
