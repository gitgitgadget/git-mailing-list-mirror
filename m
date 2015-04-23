From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/5] RelNotes: refer to the rebase -i "todo list", not "insn sheet"
Date: Thu, 23 Apr 2015 14:27:49 +0200
Message-ID: <1429792070-22991-5-git-send-email-mhagger@alum.mit.edu>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:28:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlGEo-0005tW-5V
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 14:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934434AbbDWM2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 08:28:07 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42377 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934406AbbDWM2C (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 08:28:02 -0400
X-AuditID: 12074414-f797f6d000004084-60-5538e5518d1d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 12.6D.16516.155E8355; Thu, 23 Apr 2015 08:28:01 -0400 (EDT)
Received: from michael.fritz.box (p4FC97208.dip0.t-ipconnect.de [79.201.114.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3NCRsfN011822
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 23 Apr 2015 08:28:00 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqBv41CLU4P9WdouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5YvlS6YDZXxeKfDUwNjPM5
	uhg5OSQETCR2fz3BAmGLSVy4t56ti5GLQ0jgMqPEl7M7WCCc40wS/Rs+gVWxCehKLOppZgKx
	RQTUJCa2HQKLMws4SGz+3MgIYgsLBEs0X7kCVsMioCpx/+IP1i5GDg5eAReJmZv4IZbJSZw/
	/pMZxOYUcJXYPr0NzBYCKvl85w77BEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0LfRy
	M0v0UlNKNzFCAkVkB+ORk3KHGAU4GJV4eF9kW4QKsSaWFVfmHmKU5GBSEuU9exMoxJeUn1KZ
	kVicEV9UmpNafIhRgoNZSYR3z22gHG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQi
	mKwMB4eSBK/iE6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBcxBcDIwMkxQO0
	txKknbe4IDEXKArReopRUUqctw4kIQCSyCjNgxsLi/9XjOJAXwrzaoNU8QBTB1z3K6DBTECD
	Zy4FG1ySiJCSamBctsn8Q3DFouN1j+0exyyLv9rJ9KtipyxToIfItO7TzzsXBTycGyPHzTLr
	Hp/f+rm2KrNieG3nythrXkz4U9bQeH2iy7r/p9m3RdS9+5iovmPvBI8sjj0NmfpV5ZsWPRJN
	v8F9ZOmiBw2LbrDlPOowObfFKvaBq0OXsnOiXPHexNKv31ZlH2hRYinOSDTUYi4q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267684>

"Todo list" is the name that is used in the user-facing documentation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/RelNotes/2.4.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.4.0.txt b/Documentation/RelNotes/2.4.0.txt
index c02de8d..7b23ca3 100644
--- a/Documentation/RelNotes/2.4.0.txt
+++ b/Documentation/RelNotes/2.4.0.txt
@@ -261,7 +261,7 @@ notes for details).
    user could have made was to choose nothing.
    (merge a9c4641 ak/add-i-empty-candidates later to maint).
 
- * The insn sheet "git rebase -i" creates did not fully honor
+ * The todo list "git rebase -i" creates did not fully honor
    core.abbrev settings.
    (merge edb72d5 ks/rebase-i-abbrev later to maint).
 
@@ -402,7 +402,7 @@ notes for details).
    (merge 77fdb8a nd/grep-exclude-standard-help-fix later to maint).
 
  * "git rebase -i" recently started to include the number of
-   commits in the insn sheet to be processed, but on a platform
+   commits in the todo list to be processed, but on a platform
    that prepends leading whitespaces to "wc -l" output, the numbers
    are shown with extra whitespaces that aren't necessary.
    (merge 2185d3b es/rebase-i-count-todo later to maint).
-- 
2.1.4
