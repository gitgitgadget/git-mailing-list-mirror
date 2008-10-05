From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/6] Add 1.0 TODO items from recent discussion by
	private mail
Date: Sun, 05 Oct 2008 18:01:51 +0200
Message-ID: <20081005160151.19886.30979.stgit@yoghurt>
References: <20081005155450.19886.43748.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 18:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmW4h-0006DS-3p
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 18:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbYJEQCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2008 12:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbYJEQCE
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 12:02:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1882 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbYJEQCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 12:02:03 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KmW3L-0007YM-00; Sun, 05 Oct 2008 17:01:51 +0100
In-Reply-To: <20081005155450.19886.43748.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97518>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 TODO |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)


diff --git a/TODO b/TODO
index 267e17e..a01daef 100644
--- a/TODO
+++ b/TODO
@@ -2,6 +2,16 @@ The TODO list before 1.0:
=20
 - more regression tests
=20
+- Convert the remaining commands to the new infrastructure.
+
+- Go through the design of the UI and make sure there's nothing hard
+  to change in there that we'll regret later.
+
+- Write a user guide. I'm thinking a document on the order of 10-30
+  pages that'll explain why one would want to use StGit, and how.
+
+- Make sure the rest of the documentation is in good shape.
+
 - use a separate index for some commands (refresh, fold etc.) so that
   files already added/removed are not automatically checked in
=20
@@ -9,7 +19,6 @@ The TODO list before 1.0:
       uses a separate index when appropriate. fold has not yet been
       converted.
=20
-- document the workflow on the StGIT wiki
 - release 1.0
=20
=20
