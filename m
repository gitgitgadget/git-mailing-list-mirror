From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] just an (stupid) idea when creating a new branch
Date: Mon, 10 Jul 2006 00:12:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607100011060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com>
 <e8p8pj$jk3$2@sea.gmane.org> <e5bfff550607082354g62e99216gc72b07055762de3a@mail.gmail.com>
 <Pine.LNX.4.63.0607091632070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060709220116.GT29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 00:12:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzhVy-000345-HS
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 00:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbWGIWMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 18:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWGIWMb
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 18:12:31 -0400
Received: from mail.gmx.de ([213.165.64.21]:5517 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161183AbWGIWMa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 18:12:30 -0400
Received: (qmail invoked by alias); 09 Jul 2006 22:12:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 10 Jul 2006 00:12:29 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060709220116.GT29115@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23568>

Hi,

On Mon, 10 Jul 2006, Petr Baudis wrote:

>   Hi,
> 
> Dear diary, on Sun, Jul 09, 2006 at 04:33:53PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > On Sun, 9 Jul 2006, Marco Costalba wrote:
> > 
> > > It is possible to add a message (and more) to a tag creating a tag
> > > object. FWIK this is not allowed for the other refs.
> > > 
> > > Why there is this (artifical?) difference between tags and the other
> > > kind of refs?
> > 
> > The tag message is nothing else than a commit message.
> 
>   huh?
> 
>   The tag message is a message in the "freeform" part of the tag object,
> but disregarding the format similiraties, it has really nothing to do
> with a commit message. (Also, commit messages don't tend to be commonly
> PGP signed. ;-)

Marco was talking about an "artificial difference", which means technical 
issues. From a technical viewpoint, the tag message is _exactly_ the same 
as a commit message.

Hth,
Dscho
