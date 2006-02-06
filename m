From: "Bertrand Jacquin (Beber)" <beber@guybrush.melee>
Subject: git-http-push and hooks
Date: Mon, 6 Feb 2006 21:52:03 +0100
Message-ID: <20060206205203.GA20973@guybrush.melee>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
X-From: git-owner@vger.kernel.org Mon Feb 06 21:52:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6DKx-0003uJ-Ne
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 21:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWBFUvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 15:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWBFUvs
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 15:51:48 -0500
Received: from mailfe04.tele2.fr ([212.247.154.108]:51347 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S964815AbWBFUvr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 15:51:47 -0500
X-T2-Posting-ID: BetTtMwqy0Jkfva2ln69X2TC1dgmj0IYgoi60RiAKx0=
X-Cloudmark-Score: 0.000000 []
Received: from guybrush.ath.cx ([80.170.85.192] verified)
  by mailfe04.swip.net (CommuniGate Pro SMTP 5.0.2)
  with ESMTPS id 111670772 for git@vger.kernel.org; Mon, 06 Feb 2006 21:51:45 +0100
Received: from beber by guybrush.ath.cx with local (Exim 4.60)
	(envelope-from <beber@guybrush.ath.cx>)
	id 1F6DL9-0005UN-HU
	for git@vger.kernel.org; Mon, 06 Feb 2006 21:52:03 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15659>

Hi,

Just a silly question :
Why aren't excute hooks/* (with +x perms) when I do a git-http-push ?
Also if i push with cg-push on the same repo but with git+ssh
protocol, hooks are execute.

Thanks

-- 
/* Beber : beber (AT) setibzh (DOT) com
 * http://guybrush.ath.cx, irc://irc.freenode.net/#{e.fr,gentoofr}
 * Guybrush @ Melee */
