From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 01/14] Fix typo
Date: Thu, 12 Jun 2008 07:34:12 +0200
Message-ID: <20080612053412.23549.4915.stgit@yoghurt>
References: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fSy-0004qz-Ts
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbYFLFe3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbYFLFe3
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:34:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2154 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbYFLFe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:34:28 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fRt-00013X-00; Thu, 12 Jun 2008 06:34:13 +0100
In-Reply-To: <20080612052913.23549.69687.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84702>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 0e0cccb..6ccdfa7 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -20,7 +20,7 @@ class Immutable(object):
     creating a whole new commit object that's exactly like the old one
     except for the commit message.)
=20
-    The L{Immutable} class doesn't acytually enforce immutability --
+    The L{Immutable} class doesn't actually enforce immutability --
     that is up to the individual immutable subclasses. It just serves
     as documentation."""
=20
