From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document the fact that commit -a is the way to go for
 simple operations
Date: Mon, 7 May 2007 13:22:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705071317580.4167@racer.site>
References: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
 <alpine.LFD.0.99.0705061904050.24220@xanadu.home> <vpqy7k1t56i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon May 07 13:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl1IO-0000DC-2Q
	for gcvg-git@gmane.org; Mon, 07 May 2007 13:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbXEGLWU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 07:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933041AbXEGLWU
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 07:22:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:59318 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933040AbXEGLWT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 07:22:19 -0400
Received: (qmail invoked by alias); 07 May 2007 11:22:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 07 May 2007 13:22:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bU/FanK8b74rpjGE2aC00NlFX16Qclv7txtaY5U
	OiCXAOSHIQMg0g
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqy7k1t56i.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46447>

Hi,

[BTW Matthieu, it seems you suffer the same problem as Jakub, since you do 
not Cc the original authors in your replies.]

On Mon, 7 May 2007, Matthieu Moy wrote:

> My proposal is not perfect, and I'm sure we can do better.
> 
> But the problem with most of git's manpages for beginners is that the
> documentation is mostly technical and factual. That is, it tells you
> what git will do if you provide such or such option, but not _why_ and
> _when_ you should use it.
> 
> Probably just a "gitlink:" to the place in the user manual which talks
> about the index would be OK here.

NAK. You should not even consider reading the man pages before reading the 
user manual. If you expect the man pages to give you a proper introduction 
into _anything_ that is your problem, not the doc's.

We have such a lovely user manual, full of examples, a nice read, and it 
even contains a section for the impatient. But the man pages are _meant_ 
to be technical. And I do not see a place in them for a back reference to 
the user manual.

Ciao,
Dscho
