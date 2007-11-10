From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: `git-send-email' doesn't specify `Content-Type'
Date: Sat, 10 Nov 2007 00:52:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711100052290.4362@racer.site>
References: <87ode3klc7.fsf@chbouib.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:53:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqebF-0000no-V9
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 01:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbXKJAxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 19:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755845AbXKJAxJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 19:53:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:52042 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755687AbXKJAxI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 19:53:08 -0500
Received: (qmail invoked by alias); 10 Nov 2007 00:53:06 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp038) with SMTP; 10 Nov 2007 01:53:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZPnFQ+YpZYpWZFI/vPFZQFWUlOfUSUcBeYkwrUZ
	8hrMMQY0GMhtHI
X-X-Sender: gene099@racer.site
In-Reply-To: <87ode3klc7.fsf@chbouib.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64292>

Hi,

On Sat, 10 Nov 2007, Ludovic Court?s wrote:

> Apparently, `git-send-email' doesn't specify the email's `Content-Type',
> notably its charset, while it should really add something like:
> 
>   Content-Type: text/plain; charset=UTF-8
> 
> Or did I miss an option or something?

Apparently.  There was a thread some days ago, about that very issue.  
Please find and read it.

Ciao,
Dscho
