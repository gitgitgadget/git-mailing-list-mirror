From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Cogito is deprecated, so don't point to it
Date: Mon, 05 Nov 2007 04:07:57 +0100
Message-ID: <20071105030608.6033.35208.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 04:08:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IosKF-0001hZ-Bq
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 04:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbXKEDIR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 22:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbXKEDIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 22:08:16 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4826 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbXKEDIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 22:08:16 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IosJh-0003E2-00; Mon, 05 Nov 2007 03:07:57 +0000
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63471>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Also available from

  git://repo.or.cz/stgit/kha.git safe

 README |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)


diff --git a/README b/README
index 0e648f5..4f20154 100644
--- a/README
+++ b/README
@@ -6,9 +6,7 @@ other repositories using standard GIT functionality.
=20
 Note that StGIT is not an SCM interface on top of GIT and it expects a
 previously initialised GIT repository (unless it is cloned using StGIT
-directly). For standard SCM operations, either use plain GIT commands
-or the Cogito tool but it is not recommended to mix them with the
-StGIT commands.
+directly). For standard SCM operations, use plain GIT commands.
=20
 For the latest version see http://www.procode.org/stgit/
 For a tutorial see http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT_Tuto=
rial
