From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push mirror mode
Date: Thu, 8 Nov 2007 12:19:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081218090.4362@racer.site>
References: <20071108121136.GG9736@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 13:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq6MG-0000HD-Iy
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 13:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757697AbXKHMTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 07:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756922AbXKHMTZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 07:19:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:40483 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753704AbXKHMTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 07:19:25 -0500
Received: (qmail invoked by alias); 08 Nov 2007 12:19:23 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp044) with SMTP; 08 Nov 2007 13:19:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OCq5lZmFOWoXtzrLadX/BoBe0h1YgmcPw8xS0sR
	8KN6LlaR2KsXzc
X-X-Sender: gene099@racer.site
In-Reply-To: <20071108121136.GG9736@shadowen.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64008>

Hi,

On Thu, 8 Nov 2007, Andy Whitcroft wrote:

> Ok, sometime back Junio sent out a proof-of-concept change to
> send-pack allowing a mirror mode.

You added/left his sign-off, but did not attribute the patches to him.  
Why?

Ciao,
Dscho

P.S.: Without tests I am opposed to inclusion.  This _definitely_ needs 
some tests.
