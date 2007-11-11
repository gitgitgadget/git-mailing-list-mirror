From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/5] Cogito is deprecated, so don't point to it
Date: Sun, 11 Nov 2007 20:43:43 +0100
Message-ID: <20071111194343.18868.98023.stgit@yoghurt>
References: <20071111193545.18868.62490.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:44:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIix-0001Or-Ro
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818AbXKKTnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 14:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756815AbXKKTns
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:43:48 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3887 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809AbXKKTnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:43:47 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IrIid-0004bU-00; Sun, 11 Nov 2007 19:43:43 +0000
In-Reply-To: <20071111193545.18868.62490.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64502>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

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
