From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] fmt-patch: understand old <his> notation
Date: Sun, 7 May 2006 01:19:01 +0200
Message-ID: <20060506231901.GB45996@dspnet.fr.eu.org>
References: <Pine.LNX.4.63.0605062252530.4155@wbgn013.biozentrum.uni-wuerzburg.de> <7viroirfur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605061527030.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 01:19:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcW3G-0007eV-Hq
	for gcvg-git@gmane.org; Sun, 07 May 2006 01:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWEFXTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 19:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWEFXTD
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 19:19:03 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:27658 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751138AbWEFXTC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 19:19:02 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 77EC3A3732; Sun,  7 May 2006 01:19:01 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605061527030.16343@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19682>

On Sat, May 06, 2006 at 03:30:38PM -0700, Linus Torvalds wrote:
> Maybe not. I've actually cursed the fact that I made "git diff X" mean 
> "diff from X to current working tree", because it almost never makes any 
> sense at all when X is anything but "HEAD".
> 
> I probably _should_ have made "git diff X" mean basically "git show X", 
> and not what it means now.

Funny, when tracking other projects I use (sometimes path-filtered)
"git diff origin" often, but I find "git show origin" utterly
uninteresting.

  OG.
