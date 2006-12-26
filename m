From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add: warn when adding an ignored file with an explicit
 request.
Date: Tue, 26 Dec 2006 17:19:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612261718070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslf3khsc.fsf@assigned-by-dhcp.cox.net> <7vodprizuw.fsf_-_@assigned-by-dhcp.cox.net>
 <empitl$t6p$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 17:20:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzF24-0001h8-5B
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 17:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWLZQT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 11:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWLZQT7
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 11:19:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:41209 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932699AbWLZQT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 11:19:59 -0500
Received: (qmail invoked by alias); 26 Dec 2006 16:19:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 26 Dec 2006 17:19:57 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <empitl$t6p$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35424>

Hi,

On Mon, 25 Dec 2006, Jakub Narebski wrote:

> P.S. Were all the patches sent as replies to introductory letter?

I actually don't like that convention at all. It makes for a _huge_ thread 
of unrelated discussions, since most of the time the series is _exactly_ 
because the patches are somewhat independent (otherwise you could not 
separate them).

Ciao,
Dscho
