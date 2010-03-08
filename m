From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-gui: fix usage of _gitworktree when creating
 shortcut for windows
Date: Mon, 8 Mar 2010 12:17:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003081214410.7596@pacific.mpi-cbg.de>
References: <20100223224955.GB11271@book.hvoigt.net> <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com> <20100223230238.GD11271@book.hvoigt.net> <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com> <20100227204108.GA33000@book.hvoigt.net>
 <20100227204549.GB33000@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Mar 08 12:10:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Noar7-00033k-L6
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 12:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070Ab0CHLKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 06:10:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:37125 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753510Ab0CHLKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 06:10:31 -0500
Received: (qmail invoked by alias); 08 Mar 2010 11:10:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 08 Mar 2010 12:10:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KAx136Q7KZwQstfJ4H14Q7h7LZaQHeZqxkFDgFi
	IK0PSf8jGmwR3/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100227204549.GB33000@book.hvoigt.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141758>

Hi,

On Sat, 27 Feb 2010, Heiko Voigt wrote:

> Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
> ---

I applied these three patches to 4msysgit.git (I was pretty surprised that 
the faulty patch made it into 1.7.0.2, but then, even my comment about the 
commit message style was met with unwillingness to change).

Thanks Heiko, for pre-emptively fixing msysGit issue 425!

Ciao,
Dscho
