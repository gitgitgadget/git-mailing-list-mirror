From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: NYU Open Source Programming Class Releases JavaGit API 0.1.0
 Alpha
Date: Tue, 5 Aug 2008 01:36:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808050127510.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <5dfc0b810808040948x6cd1f29fhaf2bf85a09cfd404@mail.gmail.com> <20080804175403.GG27666@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Linder <james.h.linder@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 01:32:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ9Xp-0003vV-P3
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 01:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbYHDXbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 19:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbYHDXbt
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 19:31:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:36810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752597AbYHDXbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 19:31:48 -0400
Received: (qmail invoked by alias); 04 Aug 2008 23:31:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 05 Aug 2008 01:31:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/L/Q0qKerLRYlYWaoGMQ8bYOeOWSToFWq6r/mYLk
	xQ+eGLlfw6yjYX
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080804175403.GG27666@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91392>

Hi,

On Mon, 4 Aug 2008, Shawn O. Pearce wrote:

> James Linder <james.h.linder@gmail.com> wrote:
>
> > Jgit/Egit, on the other hand, appear to be tightly integrated with 
> > Jgit primarily supporting Egit.
> 
> That's not really true.

I started using jgit in a project that is not yet totally public.  It is 
awesome.  (I mean jgit is awesome, even if my project does make me happy, 
too.)

And I absolutely share the puzzlement of Shawn why anybody would try to do 
their own thing in Java, instead of contributing to jgit.

Especially the fact that "JavaGit" seems to repeat the all-to-obvious 
error of Eclipse: to make a platform-independent library that depends on 
platform dependent components.

I find that kind of thinking so strange, to the point that I am really 
amazed enough to want to analyze the brain of the people inventing such 
things.

But hey, maybe there is a deeper point in it that escapes me.

Ciao,
Dscho
