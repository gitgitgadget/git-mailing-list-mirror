From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push refspec problem
Date: Wed, 7 Nov 2007 15:39:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071539100.4362@racer.site>
References: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com>
 <Pine.LNX.4.64.0711071510480.4362@racer.site> <4731D852.2080500@hackvalue.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James <jtp@nc.rr.com>, git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:40:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipn0P-00070G-2Z
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbXKGPje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbXKGPje
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:39:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:48699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752064AbXKGPjd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:39:33 -0500
Received: (qmail invoked by alias); 07 Nov 2007 15:39:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 07 Nov 2007 16:39:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fuKpYowhfIDAqeWjf/5nKUKlP/ZyZtcCRzJlIGA
	doMWerbb0Mz8+A
X-X-Sender: gene099@racer.site
In-Reply-To: <4731D852.2080500@hackvalue.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63829>

Hi,

On Wed, 7 Nov 2007, Johannes Gilger wrote:

> Johannes Schindelin wrote:
> 
> > On Wed, 7 Nov 2007, James wrote:
> > 
> >>        fetch = +refs/heads/*:refs/remotes/origin/*
> > 
> > This is a refspec.
> > 
> >>        push = ssh://james@my.server.com/home/james/scm/git/project.git/
> > 
> > This is a URL.  It does not specify any refs.  But "push =" expects a 
> > URL.
> 
> I think Johannes meant to say "But 'push =' expects a refspec." (the 
> manpage even says so).

Of course.  Thanks.

Ciao,
Dscho
