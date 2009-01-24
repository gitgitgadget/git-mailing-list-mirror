From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CR codes from git commands
Date: Sat, 24 Jan 2009 22:14:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901242213020.14855@racer>
References: <18805.64312.289059.660023@hungover.brentg.com> <alpine.LNX.1.00.0901212319310.19665@iabervon.org> <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com> <alpine.LNX.1.00.0901220238380.19665@iabervon.org> <7vbptzahra.fsf@gitster.siamese.dyndns.org>
 <e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com> <18808.39712.351656.138702@hungover.brentg.com> <alpine.LNX.1.00.0901221117110.19665@iabervon.org> <alpine.DEB.1.00.0901221751320.3586@pacific.mpi-cbg.de> <18809.60512.654436.59819@hungover.brentg.com>
 <alpine.DEB.1.00.0901231747340.21467@intel-tinevez-2-302> <18811.32772.728276.923430@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 22:15:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQpqm-0007ZU-Jp
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 22:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbZAXVOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 16:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755634AbZAXVOH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 16:14:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:36969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755614AbZAXVOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 16:14:06 -0500
Received: (qmail invoked by alias); 24 Jan 2009 21:14:04 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp070) with SMTP; 24 Jan 2009 22:14:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nDHAKK3rnECIqRYyDeQMMZjAxK7B7vfUmEbSX2i
	NZI8Gg+iDLrIaS
X-X-Sender: gene099@racer
In-Reply-To: <18811.32772.728276.923430@hungover.brentg.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107010>

Hi,

On Sat, 24 Jan 2009, Brent Goodrick wrote:

> Note that I'm coming from a CVS and Perforce user background but am 
> still new to git usage. How do I "take a look" at "7d1864c"?

Do this in a checkout of git.git:

$ git show 7d1864c

Alternatively, you can follow this URL:

	http://repo.or.cz/w/git.git?a=commitdiff;h=7d1864c

Ciao,
Dscho
