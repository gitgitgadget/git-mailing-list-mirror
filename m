From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Add platform-independent .git "symlink"
Date: Mon, 18 Feb 2008 14:54:13 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181454000.30505@racer.site>
References: <alpine.LSU.1.00.0802181334010.30505@racer.site> <1203345866-4881-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:55:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR7OX-0001ZZ-CB
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYBROy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbYBROy0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:54:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:43641 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752265AbYBROy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:54:26 -0500
Received: (qmail invoked by alias); 18 Feb 2008 14:54:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 18 Feb 2008 15:54:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ho5wFfwqH55jSQFXVgdfHrYgZBp2D+2v8Bw/uzo
	UVEGV2a2j20GaA
X-X-Sender: gene099@racer.site
In-Reply-To: <1203345866-4881-1-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74300>

Hi,

On Mon, 18 Feb 2008, Lars Hjemli wrote:

> On Feb 18, 2008 2:35 PM, Johannes Schindelin wrote:
> > I meant writing a readable, but invalid .git file.  Then testing that 
> > Git die()s with the correct message.
> 
> Something like this?

Sure.

Ciao,
Dscho
