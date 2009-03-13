From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 11:51:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903131149200.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se> <43d8ce650903130125m6335d189obbcdb86ec9036083@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:51:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li4zM-0008Sg-VW
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbZCMKuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 06:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbZCMKuL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 06:50:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:37204 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754380AbZCMKuK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 06:50:10 -0400
Received: (qmail invoked by alias); 13 Mar 2009 10:50:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 13 Mar 2009 11:50:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w5tloCjHwinlE1IUyvDevr6t1zsgq3TVUls25AL
	gjQvhbfLTQBAj1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <43d8ce650903130125m6335d189obbcdb86ec9036083@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113168>

Hi,

On Fri, 13 Mar 2009, John Tapsell wrote:

> 2009/3/13 Peter Krefting <peter@softwolves.pp.se>:
>
> > Doing "git push remote" pushes all my local branches by default. Is 
> > there a way to set it to *not* do that, and (for this particular 
> > remote repository) just push the current branch?
> 
> > Or failing that, not allow me to run "git push" without specifying a 
> > branch?
> 
> I've been pushing for this behaviour, and there was a patch a few days 
> ago to do this.  I'm not sure if it is/will be committed.

As Junio is a careful maintainer, he will not change anything radical 
which would piss of a lot of people _without_ a proper, long-term plan 
that gives users a chance.

I know, I once tried to push for something like that, and I am glad that 
Junio is too wise as to make Git unstable for existing users.

Ciao,
Dscho
