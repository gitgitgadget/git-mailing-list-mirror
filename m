From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Thu, 5 Jun 2008 05:25:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050523120.21190@racer>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806032115340.13507@racer.site.net> <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz> <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain>
 <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806041641150.13507@racer.site.net> <20080605010330.GB24466@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jaroslav Kysela <perex@perex.cz>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 06:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K474L-0008QH-5g
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 06:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbYFEE00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 00:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYFEE00
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 00:26:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:35692 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751166AbYFEE00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 00:26:26 -0400
Received: (qmail invoked by alias); 05 Jun 2008 04:26:24 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp050) with SMTP; 05 Jun 2008 06:26:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187b91pjwM7awmgU0B5xAIsarzIydhxObf22UZOqj
	J7Gp3/Xnnlr3c4
X-X-Sender: gene099@racer
In-Reply-To: <20080605010330.GB24466@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83854>

Hi,

On Thu, 5 Jun 2008, Stephan Beyer wrote:

> > - as has been pointed out several times now, you _are_ the committer, 
> >   and you seem to want to lie there.
> 
> Lying is already possible with GIT_COMMITTER_{NAME,EMAIL,NAME} 
> environment variables.

Of course it is possible!  I even pointed to a method!

The _point_ was that we do not want to recommend it.  And giving prominent 
support for it, such as introducing a command line parameter, _would_ 
have the effect of recommending it.

Ciao,
Dscho
