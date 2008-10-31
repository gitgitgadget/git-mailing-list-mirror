From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file modification
 time
Date: Fri, 31 Oct 2008 23:14:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810312314190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com> <1225344554.10803.17.camel@maia.lan> <20081031070003.GA4458@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:09:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2Ap-0001Mt-L4
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbYJaWHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbYJaWHm
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:07:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:40517 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752312AbYJaWHm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:07:42 -0400
Received: (qmail invoked by alias); 31 Oct 2008 22:07:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 31 Oct 2008 23:07:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fL6cKxmnfjxK22LSR0vp+O6yF9dTlIudkl5TWSw
	oYjLl8XfqYOkB3
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081031070003.GA4458@blimp.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99658>

Hi,

On Fri, 31 Oct 2008, Alex Riesen wrote:

> ActiveState Perl on Windows is portable? To another windows, maybe.

/me wonders why you could not use the Perl that ships with Git for 
Windows, at least for the purposes of Git.

Ciao,
Dscho
