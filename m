From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Wed, 26 Jul 2006 04:11:45 +0200
Message-ID: <20060726021145.GW13776@pasky.or.cz>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060726010358.20964.80443.stgit@machine> <Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0607260402460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 04:11:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5YsK-0002Vn-9C
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 04:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWGZCLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 22:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWGZCLs
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 22:11:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55982 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030360AbWGZCLr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 22:11:47 -0400
Received: (qmail 25734 invoked by uid 2001); 26 Jul 2006 04:11:45 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607260402460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24200>

  Hi,

Dear diary, on Wed, Jul 26, 2006 at 04:03:32AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Wed, 26 Jul 2006, Johannes Schindelin wrote:
> 
> > - private_Error.pm is not used. I had to rename it for Error.pm to be
> >   picked up.
> 
> Never mind. After I finally got the GITPERLLIB thing right, it did pick 
> Error.pm up.

  cool. How did you tweak it?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
