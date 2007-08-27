From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Remove duplicate text
Date: Mon, 27 Aug 2007 08:54:32 +0300
Organization: Private
Message-ID: <absdfron.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 07:51:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPXVD-0001Dm-7n
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 07:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbXH0Fuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 01:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbXH0Fuh
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 01:50:37 -0400
Received: from main.gmane.org ([80.91.229.2]:47810 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbXH0Fuh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 01:50:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPXUZ-0001eL-17
	for git@vger.kernel.org; Mon, 27 Aug 2007 07:50:27 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 07:50:27 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 07:50:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:Nya9WCcmaQZQh/PJt+RH/b+gV0M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56763>

Options -d, -l, -v have already been explained in OPTIONS below.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-tag.txt |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 70235e8..74a7e2e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -33,13 +33,6 @@ A GnuPG signed tag object will be created when `-s` or `-u
 committer identity for the current user is used to find the
 GnuPG key for signing.
 
-`-d <tag>` deletes the tag.
-
-`-v <tag>` verifies the gpg signature of the tag.
-
-`-l <pattern>` lists tags that match the given pattern (or all
-if no pattern is given).
-
 OPTIONS
 -------
 -a::
-- 
1.5.3.rc5
