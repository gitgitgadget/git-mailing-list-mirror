From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] just an (stupid) idea when creating a new branch
Date: Mon, 10 Jul 2006 00:01:16 +0200
Message-ID: <20060709220116.GT29115@pasky.or.cz>
References: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com> <e8p8pj$jk3$2@sea.gmane.org> <e5bfff550607082354g62e99216gc72b07055762de3a@mail.gmail.com> <Pine.LNX.4.63.0607091632070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 00:01:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzhL9-0001eT-AW
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 00:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbWGIWBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 18:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWGIWBS
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 18:01:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19626 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161176AbWGIWBR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 18:01:17 -0400
Received: (qmail 20924 invoked by uid 2001); 10 Jul 2006 00:01:16 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607091632070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23567>

  Hi,

Dear diary, on Sun, Jul 09, 2006 at 04:33:53PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Sun, 9 Jul 2006, Marco Costalba wrote:
> 
> > It is possible to add a message (and more) to a tag creating a tag
> > object. FWIK this is not allowed for the other refs.
> > 
> > Why there is this (artifical?) difference between tags and the other
> > kind of refs?
> 
> The tag message is nothing else than a commit message.

  huh?

  The tag message is a message in the "freeform" part of the tag object,
but disregarding the format similiraties, it has really nothing to do
with a commit message. (Also, commit messages don't tend to be commonly
PGP signed. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
