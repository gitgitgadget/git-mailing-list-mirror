From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] What do you think about adding graphical merge to
 git-gui?
Date: Fri, 7 Mar 2008 12:54:52 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803071254310.19395@racer.site>
References: <200803071240.09999.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 12:55:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXbB1-00079o-1B
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 12:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758922AbYCGLyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 06:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758797AbYCGLyw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 06:54:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:42908 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759449AbYCGLyv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 06:54:51 -0500
Received: (qmail invoked by alias); 07 Mar 2008 11:54:49 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 07 Mar 2008 12:54:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gwP1bPJtgiPPSuVadvnFESu5fGDkuZvblo02gtG
	UfS3TJqHrz+atW
X-X-Sender: gene099@racer.site
In-Reply-To: <200803071240.09999.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76481>

Hi,

On Fri, 7 Mar 2008, Jakub Narebski wrote:

> What do you think about adding "merge" subcommand to git-gui,
> or to be more exact adding tree-level merge and/or file-level
> merge tool to git-gui? I think we could "borrow" some code from
> TkDiff: http://tkdiff.sourceforge.net/ (which is also GPL)

Is there any reason not to use mergetool?

Ciao,
Dscho

