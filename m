From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 4 Aug 2007 17:16:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041715140.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com> <46B4A47E.5030901@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:43:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMj5-0004yL-JQ
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763745AbXHDQng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760586AbXHDQng
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:43:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:44910 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760886AbXHDQnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:43:35 -0400
Received: (qmail invoked by alias); 04 Aug 2007 16:16:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 04 Aug 2007 18:16:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aDnsuTYGalpeFJJQOFn7VZZiwrq1nm46A8fmRJH
	9cMIZE1omgMr0/
X-X-Sender: gene099@racer.site
In-Reply-To: <46B4A47E.5030901@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54882>

Hi,

On Sat, 4 Aug 2007, Mark Levedahl wrote:

> git checkout-index -a -f --prefix="$mandir"/

Just to hazard a guess... you see an error message there, such as "cannot 
chdir to <blablabla>: No such file or directory"?

It's kinda hard to debug this with incomplete information.

Ciao,
Dscho
