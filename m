From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/2] cvsimport: add test illustrating a bug in cvsps
Date: Thu, 19 Mar 2009 12:00:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191159110.10279@pacific.mpi-cbg.de>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net> <7vfxhag07g.fsf@gitster.siamese.dyndns.org>
 <49C22166.3000807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <git-list@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, ydirson@altern.org,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 12:00:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFzR-0002at-A5
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 12:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbZCSK7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbZCSK7G
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:59:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:45787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752426AbZCSK7F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 06:59:05 -0400
Received: (qmail invoked by alias); 19 Mar 2009 10:59:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 19 Mar 2009 11:59:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19py45lTUxpqySZcPLMT+x1uYyfz1Ykz1Mjnyt4vC
	/XHYpikoINgmdc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49C22166.3000807@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113756>

Hi,

On Thu, 19 Mar 2009, Michael J Gruber wrote:

> cvsps development should procede wherever all cvsps developers can 
> participate. It's not a central component of git.

You are forgetting a central fact to this discussion: cvsps is not 
actively developed anymore.

Virtually all the "recent" patches going into cvsps (IIRC all patches 
between the last two releases) were coming directly from the Git 
community.

Ciao,
Dscho
