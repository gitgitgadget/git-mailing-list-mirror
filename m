From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Thu, 17 Jan 2008 19:17:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171916350.5731@racer.site>
References: <20080114202932.GA25130@steel.home>  <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>  <200801160002.51048.robin.rosenberg.lists@dewire.com>  <20080116071832.GA2896@steel.home>  <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
  <20080116183124.GA3181@steel.home>  <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com>  <20080116191737.GD3181@steel.home>  <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com>  <20080116234527.GA3499@steel.home>
 <a5eb9c330801171037v333becc2lbc5873383d07a358@mail.gmail.com> <alpine.LFD.1.00.0801171046040.14959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Umbers <paul.umbers@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 20:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFaFX-0000UG-8L
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 20:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYAQTRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 14:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYAQTRe
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 14:17:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:49371 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751882AbYAQTRd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 14:17:33 -0500
Received: (qmail invoked by alias); 17 Jan 2008 19:17:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 17 Jan 2008 20:17:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19niJk+ZkhnKKfcdOOnudeOm1Ix7B2vAim1zq0VVm
	TkbUK2+W9k6LeL
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801171046040.14959@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70909>

Hi,

On Thu, 17 Jan 2008, Linus Torvalds wrote:

> On Thu, 17 Jan 2008, Paul Umbers wrote:
> > 
> > Incidentally, I've tried this on two other machines at work with the 
> > same results. The steps to reproduce are annoyingly simple: download 
> > cygwin installer & execute (accept all defaults), select the packages 
> > specified for the binary windows install on the git wiki, try to 
> > create a git repository and add files. Frustrating - especially since 
> > my desktop at my last job worked just fine.
> 
> Is there perhaps some odd virus scanner or something that interferes 
> with filesystem operations?

Or that Logitech Abomination of an "Updater service"?  On one of my 
machines, I had tons of problems before just uninstalling those "drivers".

Ciao,
Dscho
