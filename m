From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 18:02:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:03:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4XB-0007Pf-Fo
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWITQCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWITQCq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:02:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:40581 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751697AbWITQCq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:02:46 -0400
Received: (qmail invoked by alias); 20 Sep 2006 16:02:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 20 Sep 2006 18:02:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060920155431.GO8259@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27355>

Hi,

On Wed, 20 Sep 2006, Petr Baudis wrote:

> Dear diary, on Wed, Sep 20, 2006 at 05:28:08PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > However, you can tell git that Jeff is being difficult by marking such 
> > branches individually as being rebased.
> 
> This is really a wrong way of describing the problem - I'd say that Git
> is being difficult here. The point is, the subsystem maintainers need to
> maintain stacks of patches and rebase against the main kernel branch
> regularily, and they want to still publish their current state. So it's
> not really any of them being strange or difficult, but Git being so
> because it has no seamless support for tracking those branches.

So, what exactly do you propose? I do not see any way to help this 
problem, since you really throw away history. So, the 
git-is-being-difficult has to be taken with a pound of salt here.

Ciao,
Dscho
