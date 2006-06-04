From: Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] Support for configurable git command aliases (v2)
Date: Mon, 5 Jun 2006 00:11:14 +0200
Message-ID: <mj+md-20060604.221036.15619.albireo@ucw.cz>
References: <20060604211931.10117.82695.stgit@machine.or.cz> <20060604212050.GV10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 00:11:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn0oX-0006JG-Vy
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 00:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWFDWLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWFDWLM
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 18:11:12 -0400
Received: from albireo.ucw.cz ([84.242.87.5]:58763 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S932280AbWFDWLM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 18:11:12 -0400
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id 5415311008F; Mon,  5 Jun 2006 00:11:14 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20060604212050.GV10488@pasky.or.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21288>

Hello, world!

> And I forgot to mention that it also adds the interactivity test
> requested by Janek - aliases are now interpreted only when stdout is a
> tty.

Does this really make sense? Why should an alias stop working
if I happen to redirect its output? Or am I missing something?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
God is real, unless declared integer.
