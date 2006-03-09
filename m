From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] allow double click on current HEAD id after git-pull
Date: Thu, 9 Mar 2006 22:02:50 +0100
Message-ID: <20060309210250.GY31278@pasky.or.cz>
References: <20060211112630.GA12421@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olaf Hering <olh@suse.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 22:03:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHSH8-00055N-0d
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 22:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWCIVCO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 16:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCIVCO
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 16:02:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:10206 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750722AbWCIVCO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 16:02:14 -0500
Received: (qmail 8050 invoked by uid 2001); 9 Mar 2006 22:02:50 +0100
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20060211112630.GA12421@suse.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17437>

Dear diary, on Sat, Feb 11, 2006 at 12:26:30PM CET, I got a letter
where Olaf Hering <olh@suse.de> said that...
> Double click on to current HEAD commit id is not possible,
> the dot has to go.
> 
> olaf@pomegranate:~/kernel/git/linux-2.6> git-pull
> Unpacking 194 objects
>  100% (194/194) done
> * refs/heads/origin: fast forward to branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> Updating from 5bc159e6cb7ca8d173195919ee935885c129011e to 25bf368b3d98668c5d5f38e2201d8bca16e52680.
                                                                                                    ^

Junio, is there any particular reason why this hasn't been applied?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
