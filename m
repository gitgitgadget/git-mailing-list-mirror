From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Fri, 31 Oct 2008 17:46:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810311745030.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 17:40:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvx3C-0004IZ-3c
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 17:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbYJaQjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 12:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYJaQjT
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 12:39:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:54901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750881AbYJaQjS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 12:39:18 -0400
Received: (qmail invoked by alias); 31 Oct 2008 16:39:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 31 Oct 2008 17:39:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IQsQwI5uIQraECn8wpQzSGLcSCwkLhXV7lqE6Tg
	niQEYdfz2xGyf8
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081031003154.GA5745@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99600>

Hi,

On Thu, 30 Oct 2008, Jeff King wrote:

> On Wed, Oct 29, 2008 at 05:22:00PM -0700, Sam Vilain wrote:
> 
> > +  * 'git branch --switch' : alternative to checkout
> 
> Blech. I think switching branches is the one thing that checkout does 
> unconfusedly. And this is much more typing. Not to mention that So I 
> would rather see "git switch" if checkout is somehow unpalatable.

You know, I asked for this because a _user_ told me "Guess how long it 
took me to find out how to check out a branch!".

I think if you are not confused by CVS/SVN, the name "checkout" is utterly 
unintuitive.

Ciao,
Dscho
