From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [announce] text-based tree visualizer
Date: Thu, 6 Mar 2008 20:46:05 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803062045371.3941@racer.site>
References: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr> <alpine.LSU.1.00.0803061924350.3941@racer.site> <Pine.LNX.4.64.0803061938550.7660@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:47:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXM3D-0002zb-1U
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 20:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758704AbYCFTqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 14:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762874AbYCFTqH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 14:46:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:54591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765933AbYCFTqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 14:46:04 -0500
Received: (qmail invoked by alias); 06 Mar 2008 19:46:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 06 Mar 2008 20:46:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+u+lM5oQ2ugtEi+cV90iqv6hyHbm0BgqS0MtiM9B
	4fpC/dS93618dG
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0803061938550.7660@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76413>

Hi,

On Thu, 6 Mar 2008, Jan Engelhardt wrote:

> 
> On Mar 6 2008 19:24, Johannes Schindelin wrote:
> >On Thu, 6 Mar 2008, Jan Engelhardt wrote:
> >
> >> I spent the last two days writing a text-based tree visualizer; gitk 
> >> is really convenient, but unfortunately it needs an X display, tigs 
> >> tree view left me unimpressed, and I actually wanted a tool that does 
> >> not read all commits in like gitk/tig do, but just gives me the 
> >> treeview.
> >> 
> >> Screenshot:
> >> http://jengelh.hopto.org/other/git-forest.png
> >> Program (perl):
> >> http://dev.computergmbh.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest
> >> Top of file contains option overview.
> >
> >Nice.  Have you tested how it compares against tig (hit 'g'...)?
> 
> Yes, see above? :-) "tig's treeview" - that meant the 'g' key.

Yes, I saw that, thank you.

> It just uses boring ascii, fails to display octopus merges and 'octoups 
> branching', is limited to 'one branch' (e.g. no apparent way to pass 
> --all to git-log/git-rev-list).

That was what I was interested in.

Thank you,
Dscho

