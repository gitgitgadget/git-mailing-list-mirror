From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/CodingGuidelines: improve header includes
 rules
Date: Tue, 14 Apr 2009 18:24:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904141822030.10279@pacific.mpi-cbg.de>
References: <20090414003433.39cbdea2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 18:23:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtlQ7-0003IE-DM
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 18:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbZDNQWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 12:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZDNQV7
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 12:21:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:34976 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751896AbZDNQV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 12:21:58 -0400
Received: (qmail invoked by alias); 14 Apr 2009 16:21:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 14 Apr 2009 18:21:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Gb7sBCIYGR3lAZMH370FlPLtR/ri15zEx4cyEKt
	dQ5OFVu+yEfVJM
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090414003433.39cbdea2.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116544>

Hi,

On Tue, 14 Apr 2009, Christian Couder wrote:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/CodingGuidelines |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)

I think that there is a very real possiblity here to make this document so 
long that hardly anybody reads it to the end.

And is there not a real chance that your change is actually covered by

	As for more concrete guidelines, just imitate the existing code

?

Ciao,
Dscho
