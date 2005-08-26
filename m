From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] cogito bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:01:34 +0300
Message-ID: <11250540944027-git-send-email-tv@debian.org>
References: <11250540943597-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:04:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8by5-0006zI-SL
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVHZLBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHZLBs
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:01:48 -0400
Received: from i1.inoi.fi ([194.100.97.46]:58525 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S932558AbVHZLBp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:01:45 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id C1C3FFF7F9;
	Fri, 26 Aug 2005 14:01:51 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 5B49EFF9DD;
	Fri, 26 Aug 2005 14:01:51 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id F2948BA069;
	Fri, 26 Aug 2005 14:01:34 +0300 (EEST)
In-Reply-To: <11250540943597-git-send-email-tv@debian.org>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7799>

Stylistical improvements on Debian package description.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit 97b501908e075bfd1f97261f94842669e7b4db5b
tree ee48eaa9d8fbf6db7c2a19cfd93de52d60938655
parent 0b1227b120532fe2d8b48ad2d43b2f002241f8d9
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:02 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:02 +0300

 debian/control |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -10,8 +10,8 @@ Architecture: all
 Depends: git-core, patch, diff, rcs
 Recommends: rsync, curl, wget, rsh-client
 Conflicts: cgvg
-Description: version control system
- Cogito is a version control system layered on top of the git tree history
- storage system. It aims at seamless user interface and ease of use, providing
- generally smoother user experience than the "raw" Core GIT itself and indeed
- many other version control systems.
+Description: A version control system layered on top of git
+ A version control system layered on top of the git tree history
+ storage system. It aims at seamless user interface and ease of use,
+ providing generally smoother user experience than the "raw" Core GIT
+ itself and indeed many other version control systems.
