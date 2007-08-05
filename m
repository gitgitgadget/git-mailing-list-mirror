From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: $GIT_DIR usage
Date: Sun, 5 Aug 2007 14:41:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051440460.14781@racer.site>
References: <46B59F63.8020707@gmail.com> <Pine.LNX.4.64.0708051332230.14781@racer.site>
 <46B5CA50.3050500@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 15:42:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHgMz-00069V-Pw
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 15:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbXHENmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 09:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbXHENmF
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 09:42:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:33945 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751280AbXHENmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 09:42:03 -0400
Received: (qmail invoked by alias); 05 Aug 2007 13:42:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 05 Aug 2007 15:42:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+H1uJ5XOqHBmbwPZU+vxterw38iIIMQlqwaF4bdf
	H/W4KqaCOBmNEx
X-X-Sender: gene099@racer.site
In-Reply-To: <46B5CA50.3050500@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55017>

Hi,

On Sun, 5 Aug 2007, Dan Zwell wrote:

> I can do 2 things: I can change core.bare to true, or I can create .git 
> in the normal way, then move rename it. Both things still have the 
> problem of git not knowing where the working directory is. Is the only 
> way to fix this in 1.5.2.4, or is my only option to upgrade?

I really have to ask now: why is ./.git/ not an appropriate name?

Ciao,
Dscho
