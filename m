From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 4 Aug 2007 17:04:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041704040.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:12:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMEU-00055l-DJ
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764681AbXHDQMB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764690AbXHDQMB
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:12:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:37980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759572AbXHDQMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:12:00 -0400
Received: (qmail invoked by alias); 04 Aug 2007 16:05:17 -0000
Received: from unknown (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 04 Aug 2007 18:05:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DMLhfgLhDwMqH7KtG6AVGUIGaYujIjG73c1u3BX
	HhYYgD/NVka0ui
X-X-Sender: gene099@racer.site
In-Reply-To: <46B4A2B0.9080208@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54876>

Hi,

On Sat, 4 Aug 2007, Mark Levedahl wrote:

> git>git bisect good

Could you please

	GIT_TRACE=1 make quick-install-doc

? It breaks here, too, but because I have no origin/man branch.

Ciao,
Dscho
