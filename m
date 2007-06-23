From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-save script
Date: Sat, 23 Jun 2007 16:13:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706231612460.4059@racer.site>
References: <20070623220215.6117@nanako3.bluebottle.com>
 <Pine.LNX.4.64.0706231605160.4059@racer.site> <18045.14200.611958.870171@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nanako Shiraishi <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 17:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I27J9-0006wF-5j
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 17:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274AbXFWPNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 11:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbXFWPNX
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 11:13:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:35166 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757570AbXFWPNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 11:13:22 -0400
Received: (qmail invoked by alias); 23 Jun 2007 15:13:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 23 Jun 2007 17:13:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19medEer+VmEdxZmlwvUcJisq2xfGwgDeO6a2AkjN
	6vcIpxPLS1D0VA
X-X-Sender: gene099@racer.site
In-Reply-To: <18045.14200.611958.870171@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50741>

Hi,

On Sat, 23 Jun 2007, Bill Lear wrote:

> On Saturday, June 23, 2007 at 16:05:22 (+0100) Johannes Schindelin writes:
> >Hi,
> >
> >On Sat, 23 Jun 2007, Nanako Shiraishi wrote:
> >
> >> Here is how to use my script:
> >> 
> >>     $ git save
> >>     $ git pull
> >>     $ git save restore
> >
> >This use case has been discussed often, under the name "git-stash".
> 
> Was git-stash added as a patch yet?  If not, do you think Nanako's
> patch does not address the concerns that were raised in the
> discussion you refer to?

Obviously, I prefer my approach of installing an alias.

Ciao,
Dscho
