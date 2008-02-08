From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening
 a file
Date: Fri, 8 Feb 2008 20:40:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082040010.11591@racer.site>
References: <20080208174654.2e9e679c@pc09.procura.nl> <118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com> <7v8x1vjiic.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:41:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNa1t-0005Et-Qx
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934039AbYBHUkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935226AbYBHUkX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:40:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:57041 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934860AbYBHUkW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:40:22 -0500
Received: (qmail invoked by alias); 08 Feb 2008 20:40:20 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp034) with SMTP; 08 Feb 2008 21:40:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184J5Rro9I4Dy2wuqpWlAS1IaSF762yaD+brgOE9W
	lOJJ8Tx0wQL64X
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x1vjiic.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73140>

Hi,

On Fri, 8 Feb 2008, Junio C Hamano wrote:

> 	#ifdef FOPEN_OPENS_DIRECTORIES

Funny... our emails crossed, and you picked the same name ;-)

Ciao,
Dscho
