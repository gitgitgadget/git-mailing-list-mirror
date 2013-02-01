From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 3/6] fixup! Documentation: avoid poor-man's small caps
Date: Fri, 1 Feb 2013 19:08:56 +0100 (CET)
Message-ID: <544568068.1090092.1359742136040.JavaMail.ngmail@webmail18.arcor-online.net>
References: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net> <7vzjzodfp1.fsf@alter.siamese.dyndns.org> <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Fri Feb 01 19:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1L3A-0003Uh-Mr
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab3BASI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:08:59 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:53242 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109Ab3BASI5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 13:08:57 -0500
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id 1ED0F3AEE81;
	Fri,  1 Feb 2013 19:08:56 +0100 (CET)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 036B371952A;
	Fri,  1 Feb 2013 19:08:56 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id F1D8235AB54;
	Fri,  1 Feb 2013 19:08:55 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net F1D8235AB54
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1359742135; bh=WKixR3GACQEvwFtCIJopqsKbjrnmRDE02wdKMQQe4AU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Y8YrlLUpWbYYu8q3tCZ+08EioeKxCrg2CflgZYTWMCwVhcB7dsNcVkycX8bl7OCix
	 QlVvJZbZE7/5jkSK6foGXqPNJtToAti86XLrE+kUVF83+47cYCwyzN1vH4aPrRANXh
	 4Mz0ajlpDhbCpH+xiaD8OEi/wiZd35wGOPVWIUR4=
Received: from [188.105.106.49] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Fri, 1 Feb 2013 19:08:55 +0100 (CET)
In-Reply-To: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215240>

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/git-tools.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 338986a..ad8b823 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -29,7 +29,7 @@ Alternative/Augmentative Porcelains
    - *pg* (http://www.spearce.org/category/projects/scm/pg/)
 
    pg is a shell script wrapper around Git to help the user manage a set of
-   patches to files. pg is somewhat like quilt or StGIT, but it does have a
+   patches to files. pg is somewhat like quilt or StGit, but it does have a
    slightly different feature set.
 
 
@@ -60,7 +60,7 @@ History Viewers
 
    - *qgit* (http://digilander.libero.it/mcostalba/)
 
-   QGit is a git/StGIT GUI viewer built on Qt/C++. QGit could be used
+   QGit is a git/StGit GUI viewer built on Qt/C++. QGit could be used
    to browse history and directory tree, view annotated files, commit
    changes cherry picking single files or applying patches.
    Currently it is the fastest and most feature rich among the Git
-- 
1.8.0.msysgit.0


---
Thomas
