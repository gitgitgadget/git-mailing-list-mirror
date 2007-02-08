From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] Empty reflogs and "git log -g"
Date: Thu, 8 Feb 2007 21:02:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082102140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
 <8aa486160702072325q1d63c5d2mc1c6a492392802c6@mail.gmail.com>
 <Pine.LNX.4.63.0702082022200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702081447050.13009@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 21:02:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFFTp-000702-4I
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 21:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423286AbXBHUCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 15:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423278AbXBHUCo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 15:02:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:55146 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423286AbXBHUCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 15:02:43 -0500
Received: (qmail invoked by alias); 08 Feb 2007 20:02:41 -0000
X-Provags-ID: V01U2FsdGVkX18lXvtj9DclXgQ/PvxETgX1HKpWm9Tx4Q3R0mzujz
	6bcg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702081447050.13009@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39082>

Hi,

On Thu, 8 Feb 2007, Nicolas Pitre wrote:

> On Thu, 8 Feb 2007, Johannes Schindelin wrote:
> 
> > But if you _have_ to have it, see attached patch. I will not push for it 
> > in time for 1.5.0, though, since I have a track record of not getting 
> > patches right on the first try.
> 
> Well.... to that effect I'd suggest you use dwim_log() instead.
> Otherwise it'll break the HEAD reflog.

Thanks! I did not see that... See, I told you about my first tries with 
patches...

Ciao,
Dscho
