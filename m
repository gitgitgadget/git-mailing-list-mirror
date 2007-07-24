From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Tue, 24 Jul 2007 12:26:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241223440.14781@racer.site>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
 <Pine.LNX.4.64.0707222013200.14781@racer.site>
 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>
 <Pine.LNX.4.64.0707222238180.14781@racer.site>
 <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com>
 <Pine.LNX.4.64.0707230048570.14781@racer.site>
 <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com>
 <Pine.LNX.4.64.0707230136360.14781@racer.site>
 <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com>
 <Pine.LNX.4.64.0707231933030.14781@racer.site>
 <9e4733910707231743w759afabfvd43045ad2e2eba5a@mail.gmail.com>
 <Pine.LNX.4.64.0707240214500.14781@racer.site> <f84jh8$e27$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:26:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIX1-000457-T2
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764078AbXGXL0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763756AbXGXL0U
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:26:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:45892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763256AbXGXL0U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:26:20 -0400
Received: (qmail invoked by alias); 24 Jul 2007 11:26:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 24 Jul 2007 13:26:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+a294AAe+as2yRwDtBgEaVGVbeP+nXMw+MxzhVdW
	5u1woGSZj5aUH2
X-X-Sender: gene099@racer.site
In-Reply-To: <f84jh8$e27$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53572>

Hi,

On Tue, 24 Jul 2007, Jakub Narebski wrote:

> [Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org]

Thanks.

> Johannes Schindelin wrote:
> 
> > On Mon, 23 Jul 2007, Jon Smirl wrote:
> > 
> >> Thanks for working on this. I'd like to see it added to git toolkit. 
> > 
> > I plan to submit it to patchutils instead, since this is not really 
> > dependent on git.
> 
> Could you also add it to contrib/ area, please?

Sure.  Once it is really all fleshed out.  But I really think that 
patchutils is a better place.  That way, the script also helps the poor 
souls stuck with Mercurial or Darcs :-)

The really tedious part is the testing, and the verifying.  Fortunately, 
Jon made up for my incapability in both areas, with an incredible 
patience.

Ciao,
Dscho
