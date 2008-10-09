From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fwd: git status options feature suggestion
Date: Thu, 9 Oct 2008 11:03:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>  <20081009061136.GA24288@coredump.intra.peff.net>  <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 10:58:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnrLg-0003R6-4R
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 10:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758553AbYJII5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 04:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758539AbYJII5D
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 04:57:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:59627 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758392AbYJII5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 04:57:00 -0400
Received: (qmail invoked by alias); 09 Oct 2008 08:56:59 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 09 Oct 2008 10:56:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3lNM1Nu/3rPLVZs1JEP3lBe3lvG4V5+7vr3EW4m
	/gFIft7k9jMoE2
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97835>

Hi,

On Thu, 9 Oct 2008, Caleb Cushing wrote:

> > How about "git ls-files -o"?
> 
> doh... hadn't even heard of that command.

Which is good!  As ls-files is listed as plumbing.  Users should not need 
to call ls-files, so I like your idea about adding --new, --untracked etc. 
to "git status" (I do not agree with others that "git status" has to stay 
that non-existant "git commit --dry-run").

Could you list exactly which options you want implemented?

Ciao,
Dscho
