From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] use lockfile.c routines in git_commit_set_multivar()
Date: Fri, 27 Jul 2007 10:05:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271004580.14781@racer.site>
References: <11854689283208-git-send-email-bradford.carl.smith@gmail.com>
 <Pine.LNX.4.64.0707261926590.14781@racer.site>
 <f158199e0707261148r29419a39h7d83fc7bd0ea7df1@mail.gmail.com>
 <7vfy3a5uzv.fsf@assigned-by-dhcp.cox.net> <7v7iom5twd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bradford Smith <bradford.carl.smith@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 11:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IELlQ-0001d3-VV
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 11:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762037AbXG0JFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 05:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757241AbXG0JFd
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 05:05:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:39083 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756004AbXG0JFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 05:05:32 -0400
Received: (qmail invoked by alias); 27 Jul 2007 09:05:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 27 Jul 2007 11:05:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hD/YRgXghy4KSubyx+4kc4/gqYGd2bqyzjHZY3n
	x1jyxstippPiRe
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7iom5twd.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53909>

Hi,

On Thu, 26 Jul 2007, Junio C Hamano wrote:

> How about this?  On top of your "lockfile to keep symlink" and
> "set-multivar to use lockfile protocol" patches.

Looks very good to me!

Ciao,
Dscho
