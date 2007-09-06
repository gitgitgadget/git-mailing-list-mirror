From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 6 Sep 2007 13:08:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061308140.28586@racer.site>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com>
 <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
 <buoir6oo05v.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:09:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITGAr-0005pd-Fw
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 14:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbXIFMJN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 08:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757997AbXIFMJL
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 08:09:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:38516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757978AbXIFMJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 08:09:09 -0400
Received: (qmail invoked by alias); 06 Sep 2007 12:09:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 06 Sep 2007 14:09:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jSf9pqVBjXd+A4anXsyv21IIcdo4I8ocimd/YP+
	AcLt6suUu9TuQr
X-X-Sender: gene099@racer.site
In-Reply-To: <buoir6oo05v.fsf@dhapc248.dev.necel.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57872>

Hi,

On Thu, 6 Sep 2007, Miles Bader wrote:

> Dmitry Kakurin <dmitry.kakurin@gmail.com> writes:
> > When I first looked at Git source code two things struck me as odd:
> > 1. Pure C as opposed to C++. No idea why. Please don't talk about
> > portability, it's BS.
> 
> Just to piss you off.

Hehe.

FWIW I strongly disagree that it's BS.  As others have stated, the reasons 
are easily found, and they are no weak arguments.

Ciao,
Dscho
