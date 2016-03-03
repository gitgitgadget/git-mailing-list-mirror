From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] documentation: fix some typos
Date: Thu, 3 Mar 2016 19:43:51 +0100 (CET)
Message-ID: <2012898959.218720.1457030631200.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 19:44:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abYEA-0003Xx-Ry
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 19:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbcCCSny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 13:43:54 -0500
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:38842 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751272AbcCCSnx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2016 13:43:53 -0500
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mx.arcor.de (Postfix) with ESMTP id 3qGLgq1tW0z90mZ;
	Thu,  3 Mar 2016 19:43:51 +0100 (CET)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 396D81105D0;
	Thu,  3 Mar 2016 19:43:51 +0100 (CET)
Received: from webmail12.arcor-online.net (webmail12.arcor-online.net [151.189.8.64])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 3qGLgq1Vq3z31ls;
	Thu,  3 Mar 2016 19:43:51 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net 3qGLgq1Vq3z31ls
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1457030631; bh=ol61bFLNvtK4rF4bfFQ1F4leM4grIzc1dbnArgwedRg=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Q705WDy6fBIb8nWcnW0qnW57u2KLjMnj8HbCEkv8SiyKWU8ljd9JwyQLvtXfxqQSG
	 18YwVEmIsSTnerEseAbEGFGg69FHdTFadGbNP7j0mtVHSSRaQpyoXubT6dVsdBKeWu
	 4G6T6/F30JyCf7/Rz4XNuQDcJEvzchU9zv9hSYqM=
Received: from [88.72.111.232] by webmail12.arcor-online.net (151.189.8.64) with HTTP (Arcor Webmail); Thu, 3 Mar 2016 19:43:51 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 88.72.111.232
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288204>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/git-ls-files.txt | 2 +-
 Documentation/user-manual.txt  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0e08f56..75c3f41 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -155,7 +155,7 @@ a space) at the start of each line:
 	<eolinfo> is either "-text", "none", "lf", "crlf", "mixed" or "".
 +
 "" means the file is not a regular file, it is not in the index or
-not accessable in the working tree.
+not accessible in the working tree.
 +
 <eolattr> is the attribute that is used when checking out or committing,
 it is either "", "-text", "text", "text=auto", "text eol=lf", "text eol=crlf".
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ec6bacf..5e07454 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2134,7 +2134,7 @@ browsing the repository using gitweb. The default server when using
 instaweb is lighttpd.
 
 See the file gitweb/INSTALL in the Git source tree and
-linkgit:gitweb[1] for instructions on details setting up a permament
+linkgit:gitweb[1] for instructions on details setting up a permanent
 installation with a CGI or Perl capable server.
 
 [[how-to-get-a-git-repository-with-minimal-history]]
-- 
2.7.1.windows.1
