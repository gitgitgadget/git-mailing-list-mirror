From: Petr Baudis <pasky@suse.cz>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 19:20:47 +0200
Message-ID: <20060727172047.GB13776@pasky.or.cz>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> <20060727114105.GZ13776@pasky.or.cz> <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de> <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> <Pine.LNX.4.63.0607271602060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 19:20:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69XZ-0003cb-GF
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWG0RUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWG0RUu
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:20:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62687 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751804AbWG0RUt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:20:49 -0400
Received: (qmail 20802 invoked by uid 2001); 27 Jul 2006 19:20:47 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607271602060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24317>

  Hi,

Dear diary, on Thu, Jul 27, 2006 at 04:04:11PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Thu, 27 Jul 2006, Jon Smirl wrote:
> 
> > On 7/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > ... or whether it is neccessary for an Eclipse-plugin to something else
> > > than GPL.
> > 
> > Eclipse is not licensed GPL.
> 
> We are talking about Eclipse _plugins_ here. Often (especially when the 
> deciding people have $$ in their eyes), plugins have less restrictions 
> (for example, WSAD would not be possible if _all_ extensions to Eclipse 
> would have to be CPL).

  I concur. IANAL but from my understanding is that GPL requires just
the work and its derivatives to be free. So it's a matter of the
derivatives chain; if you write the plugin, does Eclipse become its
derivative work? Well, the derivation went the other way around, so
the plugin is derivative work of Git and possibly Eclipse. So AFAICS the
only possible clash that _might_ happen is if Git requires CVS and
Eclipse requires some other licence.

  Too bad for Eclipse's GPL-incompatible viral licence...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
