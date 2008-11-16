From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git to libgit2 code relicensing
Date: Sun, 16 Nov 2008 22:00:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811162159280.30769@pacific.mpi-cbg.de>
References: <491DE6CC.6060201@op5.se> <200811151615.42345.chriscool@tuxfamily.org> <49200914.6090506@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Nov 16 21:54:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1odB-0001mP-3k
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 21:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbYKPUwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYKPUwn
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 15:52:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:34502 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752100AbYKPUwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 15:52:43 -0500
Received: (qmail invoked by alias); 16 Nov 2008 20:52:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 16 Nov 2008 21:52:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rk3cKjL0rM3dciNW5l9GyD+RMVpY3aoebGQI/Uf
	suBqkleqKHOhn6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49200914.6090506@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101157>

Hi,

On Sun, 16 Nov 2008, Andreas Ericsson wrote:

> With the current list of ok's 73.09% of the code in git.git seems to be 
> relicenseable for the purpose of libgit2. That will provide quite a 
> kickstart.

I doubt it.  Most of that code was written with the execute-once 
mentality.  And with the we-have-posix mentality.

Two things we do not _want_ in libgit2.

Ciao,
Dscho
