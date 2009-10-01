From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 0/5] jgit diff
Date: Thu, 1 Oct 2009 23:47:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910012346510.4985@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de> <cover.1251974493u.git.johannes.schindelin@gmx.de> <20091001184721.GR14660@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 23:44:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtTSF-0000Pw-NZ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 23:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbZJAVom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 17:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbZJAVom
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 17:44:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:55808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752616AbZJAVol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 17:44:41 -0400
Received: (qmail invoked by alias); 01 Oct 2009 21:44:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 01 Oct 2009 23:44:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+P+ypFG5KPRyK+E7AiFSN8FLhqYyyJdhCt9acCyS
	dSUkTNPSzLGiLl
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091001184721.GR14660@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129412>

Hi,

On Thu, 1 Oct 2009, Shawn O. Pearce wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> > This patch series provides a rudimentary, working implementation of "jgit 
> > diff".  It does not provide all modes of "git diff" -- by far! -- but it 
> > is robust, and should provide a good starting point for further work.
> 
> I have rebased this patch series on our new JGit history, and then
> opened a bug at eclipse.org to get it through the IP review process:
> 
>   https://bugs.eclipse.org/bugs/show_bug.cgi?id=291083

Great, thanks!

Ciao,
Dscho
