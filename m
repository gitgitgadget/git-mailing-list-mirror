From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 22:38:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607272237460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  
 <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz>  
 <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com><Pine.LNX.4.64
 .0607270936200.4168@g5.osdl.org><Pine.LNX.4.63.0607271140100.11253@qynat.qv
 tvafvgr.pbz> <Pine.LNX.4.64.0607271232090.4168@g5.osdl.org>
 <Pine.LNX.4.63.0607271245200.11436@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Jon Smirl <jonsmirl@gmail.com>,
	Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 22:39:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Cd8-0002K4-Uk
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 22:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWG0Uir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWG0Uir
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 16:38:47 -0400
Received: from mail.gmx.de ([213.165.64.21]:57250 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750760AbWG0Uiq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 16:38:46 -0400
Received: (qmail invoked by alias); 27 Jul 2006 20:38:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 27 Jul 2006 22:38:45 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.63.0607271245200.11436@qynat.qvtvafvgr.pbz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24339>

Hi

On Thu, 27 Jul 2006, David Lang wrote:

> On Thu, 27 Jul 2006, Linus Torvalds wrote:
> 
> > On Thu, 27 Jul 2006, David Lang wrote:
> > > 
> > > > (*) I will, in fact, claim that the difference between a bad programmer
> > > > and a good one is whether he considers his code or his data structures
> > > > more important. Bad programmers worry about the code. Good programmers
> > > > worry about data structures and their relationships.
> > > 
> > > personally I'd add to this that after the data structures are defined and
> > > you
> > > turn to the code the API is significantly more important then the code
> > > itself.
> > 
> > I think people sometimes put too much emphasis on ABI's.
> 
> I was careful to say aPi, not aBi :-)

All Linus said about ABIs is true for APIs, too. The only difference 
between the two is, that people depend on the sacredness of ABIs even more 
than on APIs.

Ciao,
Dscho
