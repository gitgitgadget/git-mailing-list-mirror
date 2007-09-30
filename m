From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase: add --signoff option
Date: Sun, 30 Sep 2007 22:30:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709302229320.28395@racer.site>
References: <11911689111797-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:31:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6O0-0007Kb-Tj
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbXI3Vba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbXI3Vba
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:31:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:36016 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752013AbXI3Vb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:31:29 -0400
Received: (qmail invoked by alias); 30 Sep 2007 21:31:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 30 Sep 2007 23:31:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zuOpfmgBzAEod5NtKN/Wm+1vstmbi+jSdNM+gon
	zqvK9BInvnGM8r
X-X-Sender: gene099@racer.site
In-Reply-To: <11911689111797-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59571>

Hi,

On Sun, 30 Sep 2007, Steffen Prohaska wrote:

> When preparing a series of commits for upstream you may
> need to signoff commits if you forgot to do so earlier.

Why not use format-patch's --signoff option for that?

Ciao,
Dscho
