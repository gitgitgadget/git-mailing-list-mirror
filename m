From: Petr Baudis <pasky@suse.cz>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 15:11:27 +0200
Message-ID: <20060727131127.GA13776@pasky.or.cz>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> <20060727114105.GZ13776@pasky.or.cz> <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de> <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 15:12:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G65eG-00020G-UP
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 15:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWG0NLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 09:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWG0NLa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 09:11:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55212 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751283AbWG0NL3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 09:11:29 -0400
Received: (qmail 29644 invoked by uid 2001); 27 Jul 2006 15:11:27 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24286>

Dear diary, on Thu, Jul 27, 2006 at 02:54:54PM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> In general libraries should be licensed LGPL to avoid the license
> incompatibility problem. A GPL library forces the main app to be GPL
> too.

But really another main app here (Git) is ending up in the library.

You can still always use the "Git ABI" - the commands. Or you could try
having a GPL'd "Git/Eclipse toolkit" which would reduce the barrier to
only single exec per Git invocation or something, but it would be
probably somewhat tricky on the derived works playground.

> You may like trying to force GPL onto the app but many apps are
> stuck with the license they have and can't be changed since there is
> no way to contact the original developers.

At this point, git-shortlog lists exactly 200 people (at least entries
like Unknown or No name are all linux@horizon.com ;-).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
