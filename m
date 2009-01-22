From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cygwin: Convert paths for html help from posix to
 windows
Date: Thu, 22 Jan 2009 18:30:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901221829180.3586@pacific.mpi-cbg.de>
References: <20090122171605.GA16684@atjola.homenet> <7veiyv6ynm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1107129788-1232645410=:3586"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	jaeckel@stzedn.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ3Os-0006Q3-V1
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 18:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbZAVRaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 12:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbZAVRaH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 12:30:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:48756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753863AbZAVRaF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 12:30:05 -0500
Received: (qmail invoked by alias); 22 Jan 2009 17:29:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 22 Jan 2009 18:29:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uIIQ+Im2uPDhR2B3sjDYc/Aa1FoDVG5RVqara8R
	qXCkjWpMW8R6el
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7veiyv6ynm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106778>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1107129788-1232645410=:3586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 22 Jan 2009, Junio C Hamano wrote:

> Björn Steinbrink <B.Steinbrink@gmx.de> writes:
> 
> > OK, I don't really know if this is the right way to do it. Maybe when
> > the browser was built for cygwin this breaks? I have no clue,...
> 
> It might be simple enough to check if all it takes is to install a
> prepackaged browser from Cygwin suite and try to run it.  Doesn't Cygwin
> have small ones such as lynx (or links)?

Was it not the case that Cygwin programs could grok Windows paths, too?  
IIRC w3m is available, dunno about lynx.

Ciao,
Dscho

--8323328-1107129788-1232645410=:3586--
