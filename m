From: Miklos Vajna <vmiklos@suse.cz>
Subject: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 11:50:18 +0200
Message-ID: <20120816095018.GD5489@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 16 11:48:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1whA-0003IG-GU
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743Ab2HPJsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:48:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40496 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2HPJsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:48:46 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3D271A0FF5;
	Thu, 16 Aug 2012 11:48:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/git-pull.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index defb544..67fa5ee 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,6 +101,7 @@ include::merge-options.txt[]
 
 :git-pull: 1
 
+-r::
 --rebase::
 	Rebase the current branch on top of the upstream branch after
 	fetching.  If there is a remote-tracking branch corresponding to
-- 
1.7.7
