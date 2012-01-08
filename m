From: Thomas Hochstein <thh@inter.net>
Subject: Re: SVN -> Git *but* with special changes
Date: Sun, 08 Jan 2012 12:20:08 +0100
Message-ID: <gcvg.1201081220.64@landroval.ancalagon.de>
References: <1317227849979-6840904.post@n2.nabble.com> <20110928190445.GC1482@sigill.intra.peff.net> <1325999031923-7163706.post@n2.nabble.com> <20120108051051.GA10129@sigill.intra.peff.net> <1325999865995-7163737.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 14:00:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjsMY-00043o-Rh
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 14:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab2AHNAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 08:00:33 -0500
Received: from lo.gmane.org ([80.91.229.12]:53039 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555Ab2AHNAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 08:00:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RjsMN-0003zo-Ls
	for git@vger.kernel.org; Sun, 08 Jan 2012 14:00:27 +0100
Received: from p4fcce763.dip.t-dialin.net ([79.204.231.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 14:00:27 +0100
Received: from thh by p4fcce763.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 14:00:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fcce763.dip.t-dialin.net
User-Agent: ForteAgent/6.00-32.1186  Hamster/2.1.0.11
X-Uptime: 2 day(s), 17 hour(s), 29 minute(s), 3 second(s) [landroval | 66534]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188113>

Abscissa schrieb:

> Ok, I see. It's reporting 1.7.0, so that would explain it. One "sudo apt-get
> upgrade git" and...erm...well, it seems to be upgrading my whole damn
> computer, but I'll see how it all works out. Thanks!

"apt-get upgrade" will upgrade _all_ packages and doesn't take a
parameter:
| upgrade
|    upgrade is used to install the newest versions of all packages
|    currently installed on the system from the sources enumerated in
|    /etc/apt/sources.list. 

-thh
