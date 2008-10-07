From: Petr Baudis <pasky@suse.cz>
Subject: Re: [msysGit] Re: [FYI][PATCH] Customizing the WinGit installer
Date: Tue, 7 Oct 2008 11:28:19 +0200
Message-ID: <20081007092819.GW10360@machine.or.cz>
References: <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006141840.GO10360@machine.or.cz> <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de> <m3zllhpvby.fsf@localhost.localdomain> <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org> <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061246460.3208@nehalem.linux-foundation.org> <20081007015336.GU21650@dpotapov.dyndns.org> <alpine.LFD.2.00.0810061909260.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 11:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn8so-0001NF-2e
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 11:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbYJGJ2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 05:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYJGJ2W
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 05:28:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60475 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbYJGJ2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 05:28:21 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9474B3939B44; Tue,  7 Oct 2008 11:28:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810061909260.3208@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97685>

On Mon, Oct 06, 2008 at 07:10:37PM -0700, Linus Torvalds wrote:
> On Tue, 7 Oct 2008, Dmitry Potapov wrote:
> > 
> > It looks like you have changed your opinion since what you wrote half
> > a year ago.
> 
> Back then, nobody had really complained and sent in a patch to make it 
> optional.
> 
> That changes things. Once some user actually complains, and sends in a 
> fix to make the whole dialog optional, I don't see why anybody would ever 
> argue against such a patch being accepted.

Note that as mentioned in the original mail, my patch was not meant
for application upstream, just as an example for others who would like
to customize the Git installer for a particular environment. We wanted
to make Git installation/usage as simple as possible, reducing any
unnecessary steps we could - and this was an easy one.

I don't think the idea of showing GPL during installation makes
a lot of sense on its own, but I don't care much either and clicking
through licences and EULAs in wizards is a fact of life on Windows,
sadly. At least it doesn't require you to scroll down through the
licence as IIRC OpenOffice or GIMP or a similar beast did.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
