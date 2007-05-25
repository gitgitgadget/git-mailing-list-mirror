From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 11:57:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251155510.4648@racer.site>
References: <11800866643203-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 12:57:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrXU7-0004Dq-K5
	for gcvg-git@gmane.org; Fri, 25 May 2007 12:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbXEYK5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 06:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbXEYK5W
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 06:57:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:46014 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751492AbXEYK5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 06:57:21 -0400
Received: (qmail invoked by alias); 25 May 2007 10:57:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 25 May 2007 12:57:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190SMwleqt03Po8wP9cJmoU682lf+zGmR0B3/XTX0
	W1B0ZSI0Inm2YT
X-X-Sender: gene099@racer.site
In-Reply-To: <11800866643203-git-send-email-hjemli@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48357>

Hi,

On Fri, 25 May 2007, Lars Hjemli wrote:

> On 5/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 24 May 2007, Lars Hjemli wrote:
> > > What I think would be nice is some porcelain support to manually init,
> > > update and see the checked out version of selected subprojects, but as
> > > standalone commands.
> >
> > Yes, a la git-remote. I'd be much happier with that, too, especially since
> > I think that this can be a relatively small and easy-to-review script.
> 
> So, here it is. Please be kind :)

Thank you very much! And it looks small enough that I will review it right 
away.

> Btw: I've never managed to get asciidoc working on my machine, so the doc
> isn't checked in any other format than plain text.

No problem, I will check that.

Ciao,
Dscho
