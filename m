From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add pager.program config variable.
Date: Tue, 3 Jul 2007 17:30:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031729370.4071@racer.site>
References: <20070703160308.GA16629@Hermes.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 18:30:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5lGb-0003hh-Hn
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 18:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbXGCQaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 12:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757011AbXGCQaJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 12:30:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:35875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756425AbXGCQaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 12:30:07 -0400
Received: (qmail invoked by alias); 03 Jul 2007 16:30:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 03 Jul 2007 18:30:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IAsQgkKQIEtsP2ejiuHkourqtXgOMpQWXL2ywv+
	BFNbCi85U+O9HM
X-X-Sender: gene099@racer.site
In-Reply-To: <20070703160308.GA16629@Hermes.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51515>

Hi,

On Tue, 3 Jul 2007, Brian Gernhardt wrote:

>  I didn't know what name to use.  I settled on pager.program, but
>  thought that core.pager might be better since there are no other
>  options in the pager section.

Yeah, core.pager seems more consistent.

Ciao,
Dscho
