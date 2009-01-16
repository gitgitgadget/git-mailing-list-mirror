From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Fri, 16 Jan 2009 22:09:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <adf1fd3d0901160102y32a08e26q96728495fc0b6fcf@mail.gmail.com> <adf1fd3d0901160401s7a363076x1bcd8e90db4f56a1@mail.gmail.com> <200901162004.32557.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 16 22:10:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNvxn-0007a8-3x
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 22:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937560AbZAPVJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 16:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937559AbZAPVJF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 16:09:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:60725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937558AbZAPVJC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 16:09:02 -0500
Received: (qmail invoked by alias); 16 Jan 2009 21:09:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 16 Jan 2009 22:09:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SgUkgO2dSWeho7Cc8ppriwpM5eDRMM3WIU4ntmX
	F9WtFM/98StSyD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901162004.32557.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105997>

Hi,

On Fri, 16 Jan 2009, Thomas Rast wrote:

> The tip commit has some tweaks to the builtin regexes that aren't in any 
> mailed version yet; I'll resend RSN.

Note that I applied the "better" fix for the @@ -2 +1,0 @@ issue, but 
haven't sent out a redone series.

Thomas, could you pick up the patches from my 'my-next' branch and 
maintain an "official" topic branch?

Ciao,
Dscho
