From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote: add 'rm' subcommand
Date: Thu, 5 Jul 2007 23:38:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707052338150.9789@racer.site>
References: <11810859232541-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 00:38:58 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ZyT-0001J0-Gv
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 00:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759802AbXGEWiz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760024AbXGEWiy
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 18:38:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:42254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759705AbXGEWiy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 18:38:54 -0400
Received: (qmail invoked by alias); 05 Jul 2007 22:38:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 06 Jul 2007 00:38:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DDqpiC4SDjtMU0JqThZTgLCu9OZccG/N0ynyrnL
	Ot4NhM5TbmnnmP
X-X-Sender: gene099@racer.site
In-Reply-To: <11810859232541-git-send-email-jbowes@dangerouslyinc.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51701>

Hi,

On Tue, 5 Jun 2007, James Bowes wrote:

> Introduce git-remote rm <name> which will:
>  - Remove the remote config entry for <name>.
>  - Remove any config entries for tracking branches of <name>.
>  - Remove any stored remote branches of <name>.

Any word on this?

Ciao,
Dscho
