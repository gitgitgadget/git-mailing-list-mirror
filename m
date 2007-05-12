From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Subproject clones
Date: Sat, 12 May 2007 10:05:15 +0200
Message-ID: <20070512080515.GH942MdfPADPa@greensroom.kotnet.org>
References: <20070512011600.GA24354@us.ibm.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Amos Waterland <apw@us.ibm.com>
X-From: git-owner@vger.kernel.org Sat May 12 10:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmmbX-0005Kv-Bc
	for gcvg-git@gmane.org; Sat, 12 May 2007 10:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbXELIFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 04:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754940AbXELIFX
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 04:05:23 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:61981 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809AbXELIFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 04:05:20 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JHX003ZP54S2P@psmtp04.wxs.nl> for git@vger.kernel.org; Sat,
 12 May 2007 10:05:19 +0200 (MEST)
Received: (qmail 9413 invoked by uid 500); Sat, 12 May 2007 08:05:15 +0000
In-reply-to: <20070512011600.GA24354@us.ibm.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47029>

On Fri, May 11, 2007 at 09:16:00PM -0400, Amos Waterland wrote:
> In other words, given this:
> 
>  superproject
>   sub1
>    Makefile
>   sub2
>    Makefile
> 
> when somebody does `git-clone superproject', I believe they expect to
> get the same tree.  Instead, they get this:

I'm working on something like that.
See the thread at

	http://article.gmane.org/gmane.comp.version-control.git/46163

I hope to send out an updated version later this weekend.

skimo
