From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Distribution size
Date: Sat, 26 Sep 2009 18:00:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909261759410.4985@pacific.mpi-cbg.de>
References: <1253962653-sup-1882@nixos> <alpine.DEB.1.00.0909261320370.4985@pacific.mpi-cbg.de> <4ABE3091.5040600@syntevo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Marc Weber <marco-oweber@gmx.de>
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 17:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrZfa-0001aX-1c
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 17:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbZIZP6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 11:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbZIZP6f
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 11:58:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:45033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752156AbZIZP6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 11:58:35 -0400
Received: (qmail invoked by alias); 26 Sep 2009 15:58:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 26 Sep 2009 17:58:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181bmVIsFU1GsVBIuVXa6VSgGiC5TBmRbyBn2gec6
	XCxYCEmyihpYIS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4ABE3091.5040600@syntevo.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129159>

Hi,

On Sat, 26 Sep 2009, Thomas Singer wrote:

> > Funny.  Git for Windows is less than 12MB [*1*].
> 
> Well, the portable Git bundle compressed with 7zip is approx. 11MB, the 
> Git installer (maybe also using 7zip internally) is at approx. the same 
> size. Unpacked/installed on disk they are at 138MB/131MB. If you try to 
> compress it with zip, it will reduce to approx. 70MB which still is 
> quite large.

Of course, the Git installer does nothing like you claim.

> We are interested, too, in having a small(er) bundle, because we want to 
> distribute Git binaries with our Git GUI front-end, SmartGit, so the 
> user will (have the option to) get an all-inclusive-bundle.

If I see something in it for myself, I might want to help.

Ciao,
Dscho
