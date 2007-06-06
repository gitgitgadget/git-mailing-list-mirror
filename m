From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] chmod +x git-filter-branch.sh
Date: Wed, 6 Jun 2007 09:29:39 +0200
Message-ID: <20070606072939.GD32642@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 09:29:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvpxm-0006uB-U0
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 09:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbXFFH3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 03:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbXFFH3m
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 03:29:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:52360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751455AbXFFH3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 03:29:42 -0400
Received: (qmail invoked by alias); 06 Jun 2007 07:29:40 -0000
Received: from pD9EBB5B0.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.176]
  by mail.gmx.net (mp055) with SMTP; 06 Jun 2007 09:29:40 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX199SKkOkyh9qKqAINsNrUmwYEAfWeBKFIeZ/fSjsz
	xpt07Rgu2wxwGX
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49255>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
All other shell scripts are executable too and it is quite handy for
testing.
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 git-filter-branch.sh

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
old mode 100644
new mode 100755
-- 
1.5.2.1.116.g9f308
