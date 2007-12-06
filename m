From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] for-each-ref: Fix quoting style constants.
Date: Thu, 6 Dec 2007 12:19:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712061219280.27959@racer.site>
References: <1196943106-4559-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Dec 06 13:20:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Fik-0002NW-Nz
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 13:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbXLFMUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 07:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbXLFMUa
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 07:20:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:60343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752608AbXLFMU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 07:20:29 -0500
Received: (qmail invoked by alias); 06 Dec 2007 12:20:27 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp006) with SMTP; 06 Dec 2007 13:20:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vRRAvpgCv8QwYws/5QqSs+RRi94THZ3279O0Vns
	7Uba7eDcC5iyVc
X-X-Sender: gene099@racer.site
In-Reply-To: <1196943106-4559-1-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67280>

Hi,

On Thu, 6 Dec 2007, Johannes Sixt wrote:

>     $ git for-each-ref --python
>     error: more than one quoting style ?
> 
> While we are here, let's also remove the space before the question mark.

Doesn't python need that piece of whitespace? *ducks*

Ciao,
Dscho
