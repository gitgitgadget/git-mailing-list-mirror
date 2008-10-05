From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/6] Remove TODO items that have already been addressed
Date: Sun, 05 Oct 2008 18:01:40 +0200
Message-ID: <20081005160140.19886.92390.stgit@yoghurt>
References: <20081005155450.19886.43748.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 18:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmW4f-0006DS-JH
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 18:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbYJEQBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2008 12:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbYJEQBp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 12:01:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1872 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbYJEQBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 12:01:44 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KmW39-0007XV-00; Sun, 05 Oct 2008 17:01:39 +0100
In-Reply-To: <20081005155450.19886.43748.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97515>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 TODO |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)


diff --git a/TODO b/TODO
index ff52a95..3570345 100644
--- a/TODO
+++ b/TODO
@@ -1,14 +1,9 @@
 The TODO list before 1.0:
=20
 - more regression tests
-- stg help should probably pipe through the $PAGER
-- fix StGIT to run correctly in subdirectories
 - use a separate index for some commands (refresh, fold etc.) so that
   files already added/removed are not automatically checked in
-- debian package support
-- man page
 - document the workflow on the StGIT wiki
-- use same configuration file as GIT
 - release 1.0
=20
=20
@@ -18,9 +13,5 @@ The future, when time allows or if someone else does =
them:
 - multiple heads in a patch - useful for forking a patch,
   synchronising with other patches (diff format or in other
   repositories)
-- commit directly to a patch which is not top
-- patch synchronisation between between branches (as some people,
-  including me have the same patches based on different branches and
-  they have scripts for moving the changes in one to the others)
 - numeric shortcuts for naming patches near top (eg. +1, -2)
 - (config?) parameter for number of patches included by "series -s"
