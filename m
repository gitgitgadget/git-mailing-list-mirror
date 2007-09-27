From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: backup or mirror a repository
Date: Thu, 27 Sep 2007 22:56:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709272255360.28395@racer.site>
References: <1190921742.2263.17.camel@Tenacity>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dan Farina <drfarina@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 23:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib1N7-0004oq-4J
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 23:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519AbXI0V6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 17:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754863AbXI0V6F
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 17:58:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:60928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757492AbXI0V6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 17:58:04 -0400
Received: (qmail invoked by alias); 27 Sep 2007 21:58:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 27 Sep 2007 23:58:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Cvk0ZHCGCwpiIZYijmjZJvN4a6jWj6zDlrmYdj/
	HciXtSCBEmGjCn
X-X-Sender: gene099@racer.site
In-Reply-To: <1190921742.2263.17.camel@Tenacity>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59340>

Hi,

On Thu, 27 Sep 2007, Dan Farina wrote:

> I have been poking around on IRC and gmane, but haven't yet seen a 
> solution to my problem:

I guess you're looking for "git remote add --mirror origin <url>".  AFAIK 
this is not in any released version yet, though.

Ciao,
Dscho
