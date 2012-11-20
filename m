From: Alexey Molchanov <alexey.molchanov@portaone.com>
Subject: [PATCH] Fix typo in 1.8.1 release notes
Date: Tue, 20 Nov 2012 12:03:18 +0200
Organization: PortaOne, Inc.
Message-ID: <50AB5566.6040109@portaone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 11:23:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Takz0-000779-9h
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 11:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab2KTKW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 05:22:56 -0500
Received: from cn.portaone.com ([193.28.87.245]:50305 "EHLO cn.portaone.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937Ab2KTKWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 05:22:55 -0500
X-Greylist: delayed 1173 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2012 05:22:55 EST
Received: from [192.168.192.184]
	by cn.portaone.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76 (FreeBSD))
	(envelope-from <alexey.molchanov@portaone.com>)
	id 1Takfm-000CDV-Qk
	for git@vger.kernel.org; Tue, 20 Nov 2012 12:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210088>

Fix typo in documentation

Signed-off-by: Alexey Molchanov <alexey.molchanov@portaone.com>
---
 Documentation/RelNotes/1.8.1.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/1.8.1.txt b/Documentation/RelNotes/1.8.1.txt
index 107e5f3..559cd05 100644
--- a/Documentation/RelNotes/1.8.1.txt
+++ b/Documentation/RelNotes/1.8.1.txt
@@ -36,7 +36,7 @@ UI, Workflows & Features
    give the default number of context lines in the patch output, to
    override the hardcoded default of 3 lines.

- * "git format-patch" leraned the "--notes=<ref>" option to give
+ * "git format-patch" learned the "--notes=<ref>" option to give
    notes for the commit after the three-dash lines in its output.

  * "git log --grep=<pcre>" learned to honor the "grep.patterntype"
-- 
1.7.11.2
