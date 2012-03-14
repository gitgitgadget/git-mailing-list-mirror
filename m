From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] tweak relnotes: remove duplicate "an external"
Date: Wed, 14 Mar 2012 09:22:24 +0100
Message-ID: <87ipi7wq0v.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 09:22:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7jTj-000487-28
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 09:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341Ab2CNIWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 04:22:33 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:57493 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932159Ab2CNIWb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 04:22:31 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id E328DD48149
	for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:22:25 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 7CB256028F
	for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:22:24 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193085>



Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/RelNotes/1.7.10.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.txt
index 65df74b..6ea1efe 100644
--- a/Documentation/RelNotes/1.7.10.txt
+++ b/Documentation/RelNotes/1.7.10.txt
@@ -120,8 +120,8 @@ UI, Workflows & Features
    project name and description highlighted.

  * A new script "diffall" is added to contrib/; it drives an external
-   an external tool to perform a directory diff of two Git revisions
-   in one go, unlike "difftool" that compares one file at a time.
+   tool to perform a directory diff of two Git revisions in one go,
+   unlike "difftool" that compares one file at a time.

 Foreign Interface

--
1.7.10.rc0.42.gbbe5
