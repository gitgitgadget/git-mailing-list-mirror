From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] What do you think about adding graphical merge to
 git-gui?
Date: Fri, 7 Mar 2008 14:53:44 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803071453160.19395@racer.site>
References: <200803071240.09999.jnareb@gmail.com> <alpine.LSU.1.00.0803071254310.19395@racer.site> <200803071446.39468.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1744888849-1204898025=:19395"
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 14:54:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXd1i-0007zC-Iy
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 14:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757923AbYCGNxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 08:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757860AbYCGNxn
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 08:53:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:54829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757628AbYCGNxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 08:53:43 -0500
Received: (qmail invoked by alias); 07 Mar 2008 13:53:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 07 Mar 2008 14:53:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19V2/VmyN1VN5bWvauqtvWLWBQRyAWx7jkDOEZ5R9
	GnKklmF3QtFn5n
X-X-Sender: gene099@racer.site
In-Reply-To: <200803071446.39468.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76493>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1744888849-1204898025=:19395
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 7 Mar 2008, Jakub Narebski wrote:

> Dnia pi±tek 7. marca 2008 12:54, Johannes Schindelin napisa³:
> > On Fri, 7 Mar 2008, Jakub Narebski wrote:
> > 
> >> What do you think about adding "merge" subcommand to git-gui,
> >> or to be more exact adding tree-level merge and/or file-level
> >> merge tool to git-gui? I think we could "borrow" some code from
> >> TkDiff: http://tkdiff.sourceforge.net/ (which is also GPL)
> > 
> > Is there any reason not to use mergetool?
> 
> To quote original email:
> 
> >> Inspired by one of complaints in http://openradix.org/archives/349
> >>
> >> (Merging tools and file servers on Windows are lacking. Windows
> >>  users expect the revision control to supply these tools.)

Indeed, I had forgotten that, and your mail did not quote it either.

> Besides "git gui merge" can be more Git-aware than for example TkDiff 
> invoked from git-mergetool. It can offer also resolution also to tree 
> level conflicts, such as rename/rename, rename/delete and rename/add, 
> delete/modify or for example the case when one side has file in 
> subdirectory, and other has file in submodule.

Sure, go ahead.

Ciao,
Dscho

--8323584-1744888849-1204898025=:19395--
