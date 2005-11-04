From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Tags not transferred with git pull?
Date: Fri, 4 Nov 2005 17:05:03 +0100
Organization: Harddisk-recovery.com
Message-ID: <20051104160503.GC23790@harddisk-recovery.com>
References: <20051104155314.GB23790@harddisk-recovery.nl> <20051104155914.GA9567@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 04 17:08:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY44F-0002xZ-73
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 17:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbVKDQFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 11:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbVKDQFH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 11:05:07 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:57394 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1161160AbVKDQFF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 11:05:05 -0500
Received: (qmail 3790 invoked by uid 501); 4 Nov 2005 17:05:03 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051104155914.GA9567@ferdyx.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11140>

On Fri, Nov 04, 2005 at 04:59:14PM +0100, Fernando J. Pereda wrote:
> On Fri, Nov 04, 2005 at 04:53:14PM +0100, Erik Mouw wrote:
> | Is it OK that the latest git (0.99.9c) doesn't get the tags
> | (refs/tags/*) when doing a git pull? It's getting a bit of a nuisance
> | to do a separate rsync to get them right.
> 
> As Linus explained in a message earlier, a git fetch --tags will do it.

Ah, right. I got the impression that the latest git was supposed to do
that automatically with a git pull.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
