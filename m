From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Mon, 31 Jul 2006 11:38:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607311137360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060730223754.GA16364@admingilde.org>
 <20060731035737.24181.qmail@web31803.mail.mud.yahoo.com>
 <20060731072200.GE16364@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 11:38:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7UEA-0004HZ-Ol
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 11:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWGaJiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 05:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWGaJiU
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 05:38:20 -0400
Received: from mail.gmx.de ([213.165.64.21]:36565 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964814AbWGaJiT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 05:38:19 -0400
Received: (qmail invoked by alias); 31 Jul 2006 09:38:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 31 Jul 2006 11:38:18 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060731072200.GE16364@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24506>

Hi,

On Mon, 31 Jul 2006, Martin Waitz wrote:

> > I don't like it.  While this method works, it is too much effort
> > to have to run make to do this, plus it pollutes your tree.
> 
> Do you really think it is that much effort?
> What do others think? alternatives?

I think it is worth it, and it is cleaner. The only drawback: we have to 
stuff it somehow into git-instaweb...

Ciao,
Dscho
