From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [wishlist] graphical diff
Date: Mon, 19 Mar 2007 17:49:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703191748580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <001001c769fe$af8f4400$0b0aa8c0@abf.local> 
 <Pine.LNX.4.63.0703191359380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <1174322644.5639.17.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Robin Rosenberg' <robin.rosenberg.lists@dewire.com>,
	'git' <git@vger.kernel.org>
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTL31-0002Gr-GK
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbXCSQt0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbXCSQt0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:49:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:42224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030391AbXCSQt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:49:26 -0400
Received: (qmail invoked by alias); 19 Mar 2007 16:49:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 19 Mar 2007 17:49:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188tLZZmXc8hLxo1GQMp+pbY0CXFJuhsNEXLqT99B
	E0y9VzGX50Q+7w
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1174322644.5639.17.camel@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42642>

Hi,

On Mon, 19 Mar 2007, Raimund Bauer wrote:

> $ git show v1.4.0:git.c > git.c.v1.4.0
> $ git show v1.4.4:git.c > git.c.v1.4.4
> $ tkdiff git.c.v1.4.0 git.c.v1.4.4
> $ rm git.c.v1.4.0 git.c.v1.4.4

This almost looks like a script! Why don't you make it one?

Ciao,
Dscho
