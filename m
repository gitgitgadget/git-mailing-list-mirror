From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 22:26:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705272222200.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
  <4656A304.AF39A0B6@eudaptics.com>  <Pine.LNX.4.64.0705251113280.4648@racer.site>
  <46588DA4.5020109@xs4all.nl>  <Pine.LNX.4.64.0705262311380.4648@racer.site>
  <4659EDBC.7080804@xs4all.nl>  <Pine.LNX.4.64.0705272213350.4648@racer.site>
 <f329bf540705271417k1874c1f2u3acc98dc25e058b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Sun May 27 23:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsQFr-00034X-JT
	for gcvg-git@gmane.org; Sun, 27 May 2007 23:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbXE0V0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 17:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756446AbXE0V0R
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 17:26:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:54336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755728AbXE0V0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 17:26:16 -0400
Received: (qmail invoked by alias); 27 May 2007 21:26:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 27 May 2007 23:26:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192u+MrAoN2y++Z22u8Fx/G6gXg5NqoNmmAT7UVhv
	1zpTbntYQ7cVRF
X-X-Sender: gene099@racer.site
In-Reply-To: <f329bf540705271417k1874c1f2u3acc98dc25e058b9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48582>

Hi,

On Sun, 27 May 2007, Han-Wen Nienhuys wrote:

> there is a
> 
> bin/msys-1.0.dll
> bin/libW11.dll
> 
> inside the tarball. I want to know what they are, and how to build them.

Oops. I missed that. I guess that msys-1.0.dll is built from

	http://downloads.sourceforge.net/mingw/msys-1.0.10-src.tar.bz2

and that libW11.dll is built from some package in

	http://sourceforge.net/project/showfiles.php?group_id=37352

Ciao,
Dscho
