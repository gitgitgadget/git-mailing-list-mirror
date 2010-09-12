From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: RE: gitweb: please show tags file history browsing
Date: Sun, 12 Sep 2010 11:27:52 +0200
Message-ID: <000d01cb525c$c6c2b8b0$54482a10$@se>
References: <000001cb51be$ed214dd0$c763e970$@se> <m3r5h0kwn5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Jakub Narebski'" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 11:38:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouj1B-0006K4-OW
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 11:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457Ab0ILJib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 05:38:31 -0400
Received: from csmtp1.one.com ([195.47.247.21]:33260 "EHLO csmtp1.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab0ILJia (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 05:38:30 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Sep 2010 05:38:30 EDT
Received: from jockexp (84-217-13-162.tn.glocalnet.net [84.217.13.162])
	by csmtp1.one.com (Postfix) with ESMTP id 0D9611BC3CCA8;
	Sun, 12 Sep 2010 09:28:02 +0000 (UTC)
In-Reply-To: <m3r5h0kwn5.fsf@localhost.localdomain>
X-Mailer: Microsoft Office Outlook 12.0
thread-index: ActR2Fyvm2Wwg40oTT6aHvbuEguGIAAg35qQ
Content-Language: sv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156022>

> -----Original Message-----
> From: Jakub Narebski [mailto:jnareb@gmail.com]
> 
> "Tjernlund" <tjernlund@tjernlund.se> writes:
> 
> > I would really like to see where the tags are when browsing
> > file or directory history in gitweb. Would that be possible?
> 
> Hmmm... that is second such request...

:)

> 
> While it probably be possible to show tags in 'history' view, it would
> be not easy.  The problem is that 'history' view shows only commits
> that touch specified file or directory, and tagged commits usually do
> not touch those files (at least if one is using "bump version number"
> commits to tag them).
> 
> So you would have:
> 1. Design where to show those tags - they would be between shown
>    commits.
> 2. Create code which shows some/all tags that are between commits in
>    the presence of nonlinear history, without affecting performance
>    too badly.

Ah, that is too bad because I think it would really useful.
Image browsing a drivers history in the linux kernel. Then it would be
really nice to see what changes/bug fixes went into what release.

 Jocke
