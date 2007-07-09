From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix "git log --parent -m" from emitting duplicated parent
 info
Date: Mon, 9 Jul 2007 02:22:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707090220281.4248@racer.site>
References: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
 <7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 03:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7i5B-0002n9-BN
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 03:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757991AbXGIBa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 21:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756210AbXGIBa0
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 21:30:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:52410 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758746AbXGIBaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 21:30:24 -0400
Received: (qmail invoked by alias); 09 Jul 2007 01:30:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 09 Jul 2007 03:30:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oaVhF5YVomVAH400uFDrEkoTRgAq/7jr/+4Spos
	+lwAMnnEluGHqp
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51942>

Hi,

I only found this:

http://thread.gmane.org/gmane.comp.version-control.git/29222

Ciao,
Dscho
