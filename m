From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sun, 9 Jun 2013 04:59:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1306090457340.28957@s15462909.onlinehome-server.info>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org> <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info> <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
 <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info> <CAMP44s3xbvaftqbWA97S=OEFguCbRdA45ryEXECnL7yDf+L0Uw@mail.gmail.com> <CALkWK0ntWzJj1AkDzv9VvS+7e3B17HFkZLQhAu-7pQv6M7=dkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?ISO-8859-15?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 04:59:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlVrD-0004HF-5e
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 04:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab3FIC7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 22:59:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:57264 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab3FIC7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 22:59:46 -0400
Received: from mailout-de.gmx.net ([10.1.76.20]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MfTAj-1V01Xe1imJ-00P6qL for
 <git@vger.kernel.org>; Sun, 09 Jun 2013 04:59:45 +0200
Received: (qmail invoked by alias); 09 Jun 2013 02:59:45 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp020) with SMTP; 09 Jun 2013 04:59:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TyGpCtNDTEOlcWSFGscgqx/66LItQ81P8KHeeGk
	LPCvA45Mk/H46x
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CALkWK0ntWzJj1AkDzv9VvS+7e3B17HFkZLQhAu-7pQv6M7=dkw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226875>

Hi Ram,

On Sat, 8 Jun 2013, Ramkumar Ramachandra wrote:

> Felipe Contreras wrote:
> > While at it, why not re-evaluate the whole msysgit approach? I bet we
> > don't need a whole separate project just to create a Windows
> > installer. I've written Windows installers before, it's very easy to
> > do from Linux.
> 
> Yeah, taking the pain out of msysgit packaging would be a great way to
> counter this new-dependency-fud.  The main problem, as mm pointed out
> is subversion + perlxs.

Yeah, this is the main problem, and you probably will end up with a much
better (Linux-based) solution than the people who contributed to the Git
for Windows project in all those years since August 2007.

Surprise me, with code,
J
