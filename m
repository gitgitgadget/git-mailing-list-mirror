From: Sergei Organov <osv@javad.com>
Subject: [PATCH] git-remote.txt: fix typo
Date: Tue, 13 Nov 2007 21:17:47 +0300
Message-ID: <87ejet7w5f.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 21:02:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1xh-0008Ne-3U
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761651AbXKMUBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761628AbXKMUBL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:01:11 -0500
Received: from javad.com ([216.122.176.236]:1064 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761615AbXKMUBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:01:08 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADK16067712;
	Tue, 13 Nov 2007 20:01:07 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Is1wS-0005y7-LO; Tue, 13 Nov 2007 23:01:00 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64845>


Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/git-remote.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 027ba11..0da8704 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -79,7 +79,7 @@ caution.
 Fetch updates for a named set of remotes in the repository as defined by
 remotes.<group>.  If a named group is not specified on the command line,
 the configuration parameter remotes.default will get used; if
-remotes.default is not defined, all remotes which do not the
+remotes.default is not defined, all remotes which do not have the
 configuration parameter remote.<name>.skipDefaultUpdate set to true will
 be updated.  (See gitlink:git-config[1]).
 
-- 
1.5.3.4
