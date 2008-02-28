From: Xavier Maillard <xma@gnu.org>
Subject: Re: help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Thu, 28 Feb 2008 03:00:07 +0100
Organization: GNU's Not UNIX!
Message-ID: <200802280200.m1S207i0006525@localhost.localdomain>
References: <20080226070648.5d799056.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: git@vger.kernel.org, junkio@cox.net, pascal@obry.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 03:34:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUYbV-0000eu-Bm
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 03:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbYB1Cd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 21:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbYB1Cd4
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 21:33:56 -0500
Received: from master.uucpssh.org ([193.218.105.66]:53705 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbYB1Cdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 21:33:55 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 23E58C8C18; Thu, 28 Feb 2008 03:32:49 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m1S20CqQ006534;
	Thu, 28 Feb 2008 03:00:14 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m1S207i0006525;
	Thu, 28 Feb 2008 03:00:07 +0100
In-reply-to: <20080226070648.5d799056.chriscool@tuxfamily.org> (message from
	Christian Couder on Tue, 26 Feb 2008 07:06:48 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-3.167,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 1.23,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75342>

   Note that "emacsclient" is used with option "-e" to launch "woman"
   on emacs and this works only on versions >= 22.

Although reading the code, I find it nicely done, it wouldn't
apply on my current git repository without modifications.

Did you rebase your work before your patch submission ?

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
