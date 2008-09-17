From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 15:28:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0809171528120.14329@racer>
References: <1221610063-33610-1-git-send-email-jon.delStrother@bestbefore.tv>  <1221648564-56239-1-git-send-email-jon.delStrother@bestbefore.tv>  <alpine.DEB.1.00.0809171205430.14329@racer> <57518fd10809170637n585afacbs94fdddc5b8bb61b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, vmiklos@frugalware.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 16:34:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfy2k-0003D4-ES
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 16:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYIQO27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 10:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbYIQO26
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 10:28:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:51064 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752321AbYIQO26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 10:28:58 -0400
Received: (qmail invoked by alias); 17 Sep 2008 14:28:56 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO racer.local) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 17 Sep 2008 16:28:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sNZRBJ8gshQLeSXSPtxxarugtx6BhQlzBS/kENF
	P2zFullN7eRiNj
X-X-Sender: gene099@racer
In-Reply-To: <57518fd10809170637n585afacbs94fdddc5b8bb61b6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96116>

Hi,

On Wed, 17 Sep 2008, Jonathan del Strother wrote:

> On Wed, Sep 17, 2008 at 12:06 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Wed, 17 Sep 2008, Jonathan del Strother wrote:
> >
> >> -                     "^[     ]*\\(\\([       ]*"
> >> +                     "^[ \t]*\\(\\([ \t]*"
> >
> > Why?
> 
> Sorry - missed that in the original reply.  You really prefer having
> an invisible tab character to an explicit \t ?

No.  But I prefer clear-cut commits, not sneaked-in changes.  This is a 
change in the java part FYI.

Ciao,
Dscho
