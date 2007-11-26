From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 13:41:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711261340470.27959@racer.site>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
 <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
 <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
 <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net>
 <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:42:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IweDn-0006mo-SI
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 14:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbXKZNll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 08:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbXKZNll
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 08:41:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:36644 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751263AbXKZNll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 08:41:41 -0500
Received: (qmail invoked by alias); 26 Nov 2007 13:41:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 26 Nov 2007 14:41:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KLwk0mV1KH0hkYctmmi64txOy0LmwNyegLKUW69
	/ukcrr5wN1cLGw
X-X-Sender: gene099@racer.site
In-Reply-To: <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66073>

Hi,

On Mon, 26 Nov 2007, Wincent Colaiuta wrote:

> +		help_message = getenv("_GIT_CHERRY_PICK_HELP");

Why on earth do you have a leading underscore?  No existing git 
environment variable does it that way.

Ciao,
Dscho
