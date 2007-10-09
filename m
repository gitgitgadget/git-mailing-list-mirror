From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding color to git-add--interactive
Date: Tue, 9 Oct 2007 15:04:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091503460.4174@racer.site>
References: <91EBB71E-BB4E-4089-8C33-6B0C4A61223A@steelskies.com>
 <A59A0321-9E29-4857-AF03-E6226C45E87C@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 16:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfFhl-0001GW-N2
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 16:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbXJIOEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 10:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbXJIOEx
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 10:04:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:42652 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752167AbXJIOEw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 10:04:52 -0400
Received: (qmail invoked by alias); 09 Oct 2007 14:04:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 09 Oct 2007 16:04:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19euZxqyY1e/fKch6IGgUGyeQUNJ+yoooNfOAPvKW
	kPU9cUvi5JmqVt
X-X-Sender: gene099@racer.site
In-Reply-To: <A59A0321-9E29-4857-AF03-E6226C45E87C@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60414>

Hi,

On Tue, 9 Oct 2007, Wincent Colaiuta wrote:

> El 9/10/2007, a las 15:06, Jonathan del Strother escribi?:
> 
> > Or am I alone in finding interactive mode basically unreadable?
> 
> I don't think you're alone. Compared with the nice colorized output from 
> things like git-status, git-log, git-diff and friends, the output of 
> "git-add --interactive" is decidedly hard to read.

And since git-add--interactive is still a script, there is no excuse: 
providing a patch should take the same time and amount of work as 
complaining about the lack of colour.

Ciao,
Dscho
