From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 13:17:25 +0200
Message-ID: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:17:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymh2q-0000k1-W0
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 13:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbbD0LRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 07:17:44 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51137 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752431AbbD0LRn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2015 07:17:43 -0400
X-AuditID: 12074412-f79e46d0000036b4-62-553e1acc0e03
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D1.52.14004.CCA1E355; Mon, 27 Apr 2015 07:17:32 -0400 (EDT)
Received: from michael.fritz.box (p4FC9763C.dip0.t-ipconnect.de [79.201.118.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3RBHUZm030577
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 27 Apr 2015 07:17:31 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsUixO6iqHtGyi7UYH6jhUXXlW4mi4beK8wW
	lz6vZ7W4vWI+swOLx9/3H5g8Jn45zupx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGT1tS1gK
	+uQqrj9axNLA2C7ZxcjBISFgInFxnlwXIyeQKSZx4d56ti5GLg4hgcuMEpPb9jBCOCeYJJqe
	fmMEqWIT0JVY1NPMBGKLCKhJTGw7xAJiMwuUSfw7tQGsRljATKJ90SuwOIuAqsSKDedZQJbx
	CrhIfGgLg1gmJ3H++E/mCYzcCxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaU
	bmKEBIPQDsb1J+UOMQpwMCrx8BZMtg0VYk0sK67MPcQoycGkJMrLIG4XKsSXlJ9SmZFYnBFf
	VJqTWnyIUYKDWUmEd7kIUI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoND
	SYKXVRKoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4U5vHFwEAHSfEA7S0Eaect
	LkjMBYpCtJ5iVJQS5/UESQiAJDJK8+DGwmL8FaM40JfCvG9AqniA6QGu+xXQYCagwZUzbUAG
	lyQipKQaGI1uRnE97ORhOGxiozHltGpK46djfGdrC5MNJtz//FFPPENh/2+Wub8zDNcIPy64
	vcreqijxYfITDaNM3R5zneDfXo5WpzNO+t9wsFLU4lc4P3l9iWa++tTpYRXiLx/eniKw2sTa
	1/ey1MVFn3lOSyw4qXL6V8m8BeV7pvtLnD/7K17v5eM7E5RYijMSDbWYi4oTAV04 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267850>

The only changes are to the README files, most notably the list of
maintainers and the project URL.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 contrib/hooks/multimail/README     | 43 +++++++++++++++++++-------------------
 contrib/hooks/multimail/README.Git |  6 +++---
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
index 477d65f..6efa4ff 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -456,34 +456,35 @@ consider sharing them with the community!
 Getting involved
 ----------------
 
-git-multimail is an open-source project, built by volunteers.  We
-would welcome your help!
+git-multimail is an open-source project, built by volunteers. We would
+welcome your help!
 
-The current maintainer is Michael Haggerty <mhagger@alum.mit.edu>.
+The current maintainers are Michael Haggerty <mhagger@alum.mit.edu>
+and Matthieu Moy <matthieu.moy@grenoble-inp.fr>.
 
-General discussion of git-multimail takes place on the main Git
-mailing list,
+Please note that although a copy of git-multimail is distributed in
+the "contrib" section of the main Git project, development takes place
+in a separate git-multimail repository on GitHub:
 
-    git@vger.kernel.org
+    https://github.com/git-multimail/git-multimail
 
-Please CC emails regarding git-multimail to me so that I don't
-overlook them.
+Whenever enough changes to git-multimail have accumulated, a new
+code-drop of git-multimail will be submitted for inclusion in the Git
+project.
 
-The git-multimail project itself is currently hosted on GitHub:
+We use the GitHub issue tracker to keep track of bugs and feature
+requests, and we use GitHub pull requests to exchange patches (though,
+if you prefer, you can send patches via the Git mailing list with CC
+to the maintainers). Please sign off your patches as per the Git
+project practice.
 
-    https://github.com/mhagger/git-multimail
+General discussion of git-multimail can take place on the main Git
+mailing list,
 
-We use the GitHub issue tracker to keep track of bugs and feature
-requests, and GitHub pull requests to exchange patches (though, if you
-prefer, you can send patches via the Git mailing list with cc to me).
-Please sign off your patches as per the Git project practice.
-
-Please note that although a copy of git-multimail will probably be
-distributed in the "contrib" section of the main Git project,
-development takes place in the separate git-multimail repository on
-GitHub!  (Whenever enough changes to git-multimail have accumulated, a
-new code-drop of git-multimail will be submitted for inclusion in the
-Git project.)
+    git@vger.kernel.org
+
+Please CC emails regarding git-multimail to the maintainers so that we
+don't overlook them.
 
 
 Footnotes
diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multimail/README.Git
index 129b771..ab3ece5 100644
--- a/contrib/hooks/multimail/README.Git
+++ b/contrib/hooks/multimail/README.Git
@@ -3,13 +3,13 @@ section of the Git project as a convenience to Git users.
 git-multimail is developed as an independent project at the following
 website:
 
-    https://github.com/mhagger/git-multimail
+    https://github.com/git-multimail/git-multimail
 
 The version in this directory was obtained from the upstream project
-on 2014-04-07 and consists of the "git-multimail" subdirectory from
+on 2015-04-27 and consists of the "git-multimail" subdirectory from
 revision
 
-    1b32653bafc4f902535b9fc1cd9cae911325b870
+    8c3aaafa873bf10de8dddf1d202c449b3eff3b42 refs/tags/1.0.2
 
 Please see the README file in this directory for information about how
 to report bugs or contribute to git-multimail.
-- 
2.1.4
