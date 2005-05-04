From: Matt Mackall <mpm@selenic.com>
Subject: Mercurial v0.4c
Date: Tue, 3 May 2005 19:58:53 -0700
Message-ID: <20050504025852.GK22038@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 04 04:53:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTA0R-0008Oy-VC
	for gcvg-git@gmane.org; Wed, 04 May 2005 04:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVEDC7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 22:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVEDC7D
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 22:59:03 -0400
Received: from waste.org ([216.27.176.166]:38362 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261602AbVEDC67 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 22:58:59 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j442wrtB020101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 May 2005 21:58:53 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j442wr46020098;
	Tue, 3 May 2005 21:58:53 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A new version of Mercurial is available at:

 http://selenic.com/mercurial/

This version is officially self-hosting, now that I've added the final
planned changed to the metadata. To pull the repo, do:

 hg init
 hg merge http://selenic.com/hg

This version fixes numerous reported bugs, adds a "verify" command to
check the repository integrity, transaction handling, and some minor
speed improvements.

-- 
Mathematics is the supreme nostalgia of our time.
