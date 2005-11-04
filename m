From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Tags not transferred with git pull?
Date: Fri, 4 Nov 2005 16:53:14 +0100
Organization: Harddisk-recovery.com
Message-ID: <20051104155314.GB23790@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 04 16:56:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY3sj-0006FV-DG
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 16:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbVKDPxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 10:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbVKDPxY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 10:53:24 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:51760 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751547AbVKDPxS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 10:53:18 -0500
Received: (qmail 2108 invoked by uid 501); 4 Nov 2005 16:53:14 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11136>

Hi,

Is it OK that the latest git (0.99.9c) doesn't get the tags
(refs/tags/*) when doing a git pull? It's getting a bit of a nuisance
to do a separate rsync to get them right.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
