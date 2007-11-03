From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] New script: git-changelog.perl - revised
Date: Sat, 3 Nov 2007 13:58:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031357510.4362@racer.site>
References: <67837cd60711021303q488e0873lea363b93fc90d591@mail.gmail.com> 
 <472C3309.70109@op5.se> <67837cd60711030646p6d7dc8e3t8a5f5f336e8bbad6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Ronald Landheer-Cieslak <ronald@landheer-cieslak.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 14:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoJXE-0003dj-Fj
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbXKCN7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbXKCN7V
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:59:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:50325 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752941AbXKCN7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:59:20 -0400
Received: (qmail invoked by alias); 03 Nov 2007 13:59:18 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp058) with SMTP; 03 Nov 2007 14:59:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lBRI1jWZlhZVmxJJzJHVMPETHyaz57+3mNliMaU
	+z3dBOSov5ynYv
X-X-Sender: gene099@racer.site
In-Reply-To: <67837cd60711030646p6d7dc8e3t8a5f5f336e8bbad6@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63271>

Hi,

On Sat, 3 Nov 2007, Ronald Landheer-Cieslak wrote:

> On Nov 3, 2007 4:36 AM, Andreas Ericsson <ae@op5.se> wrote:
> > Ronald Landheer-Cieslak wrote:
> > >
> > > This is also available through git at
> > > git://vlinder.landheer-cieslak.com/git/git.git#topic/git-log-changelog
> > >
> >
> > This mode of specifying a repository + branch was just thoroughly shot
> > down in a list discussion, and git certainly doesn't grok it. I'd be a
> > happier fella if you didn't use it.
> >
> Is there a canonical way to specify both the location and the branch
> in one shot, then?

Yes.  Create a repository containing only that branch, as "master", and 
point people to that repository.

Hth,
Dscho
