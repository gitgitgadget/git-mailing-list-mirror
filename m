From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 12:30:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610171229160.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca>
 <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 12:30:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZmDf-00087I-Sk
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 12:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbWJQKaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 06:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWJQKaa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:30:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:42976 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161181AbWJQKaa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 06:30:30 -0400
Received: (qmail invoked by alias); 17 Oct 2006 10:30:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 17 Oct 2006 12:30:28 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29051>

Hi,

On Tue, 17 Oct 2006, Sean wrote:

> On Tue, 17 Oct 2006 00:24:15 -0400
> Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> 
> > - - you can have working trees on local systems while having the
> >   repository on a remote system.  This makes it easy to work on one
> >   logical branch from multiple locations, without getting out of sync.
> 
> That is a very nice feature.  Git would be improved if it could
> support that mode of operation as well.

It would also make things slow as hell. How do you deal with something 
like annotate in such a setup?

Ciao,
Dscho
