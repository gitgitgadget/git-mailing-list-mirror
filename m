From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening
 a file
Date: Fri, 8 Feb 2008 21:47:18 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082146400.11591@racer.site>
References: <20080208174654.2e9e679c@pc09.procura.nl> <118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com> <7v8x1vjiic.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802082040010.11591@racer.site> <7vwspfi1t4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:48:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNb5B-0005VU-1z
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbYBHVrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 16:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbYBHVrO
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:47:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:49813 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751057AbYBHVrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:47:13 -0500
Received: (qmail invoked by alias); 08 Feb 2008 21:47:11 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp040) with SMTP; 08 Feb 2008 22:47:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EyXpMinpEQbmKBNKkbXqs+zSKkgKyQo8PCUHrlL
	IG8ByB3DaqB1Dj
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwspfi1t4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73155>

Hi,

On Fri, 8 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 8 Feb 2008, Junio C Hamano wrote:
> >
> >> 	#ifdef FOPEN_OPENS_DIRECTORIES
> >
> > Funny... our emails crossed, and you picked the same name ;-)
> 
> Bad Dscho.
> 
> It has been a very well kept secret that Dscho and Junio are one
> and the same person, but you just spilled the beans.

Shush... left-hemisphere: shut up.

Ciao,
Dscho

P.S.: double ;-)
