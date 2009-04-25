From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH 1/2] Documentation: git-clean: fix minor grammatical errors
Date: Sat, 25 Apr 2009 09:13:40 -0600
Message-ID: <1240672421-10309-2-git-send-email-wjl@icecavern.net>
References: <1240672421-10309-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 17:15:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxjbC-0005Hn-OD
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 17:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbZDYPNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 11:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbZDYPNw
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 11:13:52 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:46681 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751384AbZDYPNv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 11:13:51 -0400
Received: from jenova.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id B61C43659B;
	Sat, 25 Apr 2009 09:13:44 -0600 (MDT)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id 33F08293D7F;
	Sat, 25 Apr 2009 09:13:42 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id 5D2D02FD5B; Sat, 25 Apr 2009 09:13:41 -0600 (MDT)
X-Mailer: git-send-email 1.6.2.4
In-Reply-To: <1240672421-10309-1-git-send-email-wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117557>

There were a few minor grammatical errors that made this paragraph hard
to read. This patch fixes the errors in a very minimal manner.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---

This could still be made much more readable, but this patch tries to be
very non-invasive.

 Documentation/git-clean.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 8a11450..932d44d 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -12,9 +12,9 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Removes files unknown to git.  This allows to clean the working tree
-from files that are not under version control.  If the '-x' option is
-specified, ignored files are also removed, allowing to remove all
+Removes files unknown to git.  This allows cleaning the working tree
+of files that are not under version control.  If the '-x' option is
+specified, ignored files are also removed, allowing the removal of all
 build products.
 If any optional `<path>...` arguments are given, only those paths
 are affected.
-- 
1.6.2.4
