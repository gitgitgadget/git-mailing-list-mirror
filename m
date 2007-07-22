From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] some feedbacks from the Italian Free Translation Project.
Date: Sun, 22 Jul 2007 23:26:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222324170.14781@racer.site>
References: <20070722201942.609543f1@paolo-desktop> 
 <Pine.LNX.4.64.0707222034500.14781@racer.site>
 <4d8e3fd30707221506t43a9d3e1re2e8e19c13ee2a82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:26:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjsl-0003Ze-U0
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760678AbXGVW03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759837AbXGVW03
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:26:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:53142 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759382AbXGVW02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:26:28 -0400
Received: (qmail invoked by alias); 22 Jul 2007 22:26:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 23 Jul 2007 00:26:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uWKEPGTTuKJmFlgt/pnx8OKc1kS3KCMgves3C81
	vKsR1NelHQgUdR
X-X-Sender: gene099@racer.site
In-Reply-To: <4d8e3fd30707221506t43a9d3e1re2e8e19c13ee2a82@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53353>

Hi,

On Mon, 23 Jul 2007, Paolo Ciarrocchi wrote:

> On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Sun, 22 Jul 2007, Paolo Ciarrocchi wrote:
> > 
> > > Many thanks to the Italian Free Translation Project
> > >
> > > More patches in the following days.
> > >
> > > Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> > 
> > Thanks.  Both of your patches applied, although I had to fix non-UTF-8
> > encoding.  This could well be a problem on my side.
> 
> Odd.
> Is there anything I should check in my box?

I guess that your system is set to iso-8859-1, since even your mailer says 
"Content-Type: ... ISO-8859-1".  Also, your content is "quoted-printable".

For the time being, I can convert your patches, but you might want to 
consider switching to UTF-8.

Thanks,
Dscho
