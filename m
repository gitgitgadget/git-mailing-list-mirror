From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Fri, 16 Jan 2009 02:34:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901160234160.3586@pacific.mpi-cbg.de>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org> <20090115153529.GA13961@neumann> <7vvdsgql17.fsf@gitster.siamese.dyndns.org> <bd6139dc0901151420j4ae62433uc0cc70d86dc45cfa@mail.gmail.com> <20090115225912.GL9794@neumann>
 <20090116001139.GA26357@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1413374251-1232069698=:3586"
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 02:35:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNdcP-0007AN-3n
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 02:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbZAPBeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 20:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbZAPBeH
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 20:34:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:36458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753137AbZAPBeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 20:34:06 -0500
Received: (qmail invoked by alias); 16 Jan 2009 01:34:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 16 Jan 2009 02:34:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195C7Fd8bp5F4U3eCshwElwtIMJHgtqCWLAvXQhEo
	wyQ0R8sGwaqUsZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090116001139.GA26357@atjola.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105899>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1413374251-1232069698=:3586
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 16 Jan 2009, Björn Steinbrink wrote:

> A bit off-topic: The "auto-amend" code path passes --no-verify to git 
> commit. What's the reason for doing that? I actually always expected 
> that to use my pre-commit hook to stop me from committing crap. :-/

IIRC people requested that rebase commits their crap without complaining 
:-)

Ciao,
Dscho

--8323328-1413374251-1232069698=:3586--
