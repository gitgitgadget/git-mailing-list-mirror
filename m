From: Mike Galbraith <efault@gmx.de>
Subject: Re: git-1.4.1.1-1 git-clone-pack: unable to read from
	git-index-pack
Date: Tue, 25 Jul 2006 14:18:28 +0200
Message-ID: <1153829908.2258.34.camel@Homer.simpson.net>
References: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1153829608.2258.32.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 25 14:11:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5LlO-0003JZ-NO
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 14:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWGYMLr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 08:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWGYMLr
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 08:11:47 -0400
Received: from mail.gmx.net ([213.165.64.21]:30435 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750864AbWGYMLr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 08:11:47 -0400
Received: (qmail invoked by alias); 25 Jul 2006 12:11:45 -0000
Received: from p54B5AC1A.dip0.t-ipconnect.de (EHLO Homer) [84.181.172.26]
  by mail.gmx.net (mp019) with SMTP; 25 Jul 2006 14:11:45 +0200
X-Authenticated: #14349625
To: git@vger.kernel.org
In-Reply-To: <1153829608.2258.32.camel@Homer.simpson.net>
X-Mailer: Evolution 2.6.0 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24173>

On Tue, 2006-07-25 at 14:13 +0200, Mike Galbraith wrote:
> Greetings,
> 
> Having finally acquired DSL (only 400kbps, but at least I'm in the
> twentieth century [not typo]), I decided to finally give git a try.  I
> installed git-1.4.1.1-1, and armed myself with Jeff's how-to.  I didn't
> get far before git saved me the trouble of truly testing my resolve :)
> 
> 	-Mike
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6

Oops, missed a line.

fatal: packfile '/usr/local/src/tmp/linux-2.6/.git/objects/pack/tmp-nE9k3G' SHA1 mismatch

> error: git-clone-pack: unable to read from git-index-pack
> error: git-index-pack died with error code 128
> clone-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed
