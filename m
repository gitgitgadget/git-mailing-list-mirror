From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and
 Mercurial
Date: Sun, 26 Apr 2009 12:13:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904261208000.10279@pacific.mpi-cbg.de>
References: <200904260703.31243.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 26 13:47:56 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly1Nn-00032y-R5
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 12:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbZDZKNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 06:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZDZKNO
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 06:13:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:53899 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751857AbZDZKNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 06:13:13 -0400
Received: (qmail invoked by alias); 26 Apr 2009 10:13:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 26 Apr 2009 12:13:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Cv180QhwCB/urG4lPXJsLxPViv1zx9wRvb5ZC3a
	InhTiv4ktYQzjt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200904260703.31243.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117588>

Hi,

On Sun, 26 Apr 2009, Christian Couder wrote:

> For information, now Google Code supports Mercurial for project hosting:
> 
> http://google-code-updates.blogspot.com/2009/04/mercurial-support-for-project-hosting.html
> 
> Mercurial was choosen over Git because of this (one year old) analysis:
> 
> http://code.google.com/p/support/wiki/DVCSAnalysis
> 
> There is this article on LWN about the analysis:
> 
> http://lwn.net/Articles/330138/

FWIW some little bird (yes, related to the Google Code team) told me that 
the real reason was because a certain person important in Git development 
was upsetting the Google Code team.  It _might_ be related to the fact 
that the original Googe Code team had a substantial involvement in 
Subversion...

So, don't believe that the reason Git is not supported by Google Code is a 
technical one (just like it was no technical reason at all for Python to 
choose Hg over Git).

Oh, and I have to be very clear on some important point: they are free to 
choose what they want.  I, for one, am happy that not everybody and her 
dog uses Git.  That way, we can steal cute ideas from other projects like 
Hg or Bazaar.

Ciao,
Dscho
