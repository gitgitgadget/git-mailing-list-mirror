From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 6 Jun 2008 19:11:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061911300.1783@racer>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com> <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Cedric Vivier <cedricv@neonux.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 20:14:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4gS4-0003zN-QJ
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 20:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbYFFSNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 14:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbYFFSNU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 14:13:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:48072 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754720AbYFFSNT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 14:13:19 -0400
Received: (qmail invoked by alias); 06 Jun 2008 18:13:16 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 06 Jun 2008 20:13:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6opciS3j6XmGhUQM7Tadcxf9Oudk3WvusPxbdMe
	mGoAseaJcPJcaZ
X-X-Sender: gene099@racer
In-Reply-To: <484969F0.1030704@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84096>

Hi,

On Fri, 6 Jun 2008, Paolo Bonzini wrote:

> > What about people preferring the status quo?  I think a command line 
> > option would be in order.'
> 
> config option seems more useful.

Except, of course, if you have a script that wants to override whatever 
the user set in her config.

Hth,
Dscho
