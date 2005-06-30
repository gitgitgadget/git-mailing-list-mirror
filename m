From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Thu, 30 Jun 2005 12:48:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506301246170.1667@localhost.localdomain>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
 <Pine.LNX.4.63.0506291048140.1667@localhost.localdomain>
 <pan.2005.06.29.20.40.37.811830@smurf.noris.de>
 <pan.2005.06.30.10.30.21.176648@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 18:41:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do26F-0002yk-NL
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 18:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVF3Qsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 12:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVF3Qsk
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 12:48:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:4937 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262386AbVF3Qsj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 12:48:39 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR001.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIW0005RPCY3B@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Jun 2005 12:48:35 -0400 (EDT)
In-reply-to: <pan.2005.06.30.10.30.21.176648@smurf.noris.de>
X-X-Sender: nico@localhost.localdomain
To: Matthias Urlichs <smurf@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jun 2005, Matthias Urlichs wrote:

> Hi, Matthias Urlichs wrote:
> 
> > Hi, Nicolas Pitre wrote:
> > 
> >> ftp.kernel.org/pub/scm/linux/kernel/bkcvs/linux-2.5/
> > 
> > Oh well, I'll have a look. (I never bothered with bk2cvs; there's a
> > better tool which does bk2git directly.)
> > 
> OK -- pulled, tested.
> 
> ... though why you'd want the kernel via CVS instead of by direct
> BK->GIT import is beyond me. ;-)

That's just a nice big test case.

You could try with, say, the gcc CVS as well for example.


Nicolas
