From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 17:29:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211728120.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
 <fi1ojd$pva$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 18:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IutOs-0001wW-Gr
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 18:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbXKUR3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 12:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbXKUR3x
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 12:29:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:43981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751735AbXKUR3w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 12:29:52 -0500
Received: (qmail invoked by alias); 21 Nov 2007 17:29:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 21 Nov 2007 18:29:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Yukg5xSDYjvd2NsYvJQML316wCw9ZBywRgDvqS+
	4CiFJ6cd8WZxS6
X-X-Sender: gene099@racer.site
In-Reply-To: <fi1ojd$pva$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65687>

Hi,

On Wed, 21 Nov 2007, Jakub Narebski wrote:

> We would also need "git ls-remote <bundle>" and "git fsck <bundle>" to 
> demote git-bundle to porcelain status :-)

git ls-remote <bundle> worked, last time I checked (15 seconds ago).  But 
git fsck?  Since when does something like "git fsck 
git://repo.or.cz/git.git" work?

Besides, "git bundle verify <bundle>" works quite well.

Ciao,
Dscho
