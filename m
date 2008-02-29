From: Xavier Maillard <xma@gnu.org>
Subject: Re: help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Fri, 29 Feb 2008 03:00:06 +0100
Organization: GNU's Not UNIX!
Message-ID: <200802290200.m1T206t0018000@localhost.localdomain>
References: <20080226070648.5d799056.chriscool@tuxfamily.org> <200802280200.m1S207i0006525@localhost.localdomain> <200802280453.11446.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net, pascal@obry.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 03:35:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUv5O-0005gD-C5
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 03:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbYB2CeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Feb 2008 21:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756310AbYB2CeX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 21:34:23 -0500
Received: from master.uucpssh.org ([193.218.105.66]:48027 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbYB2CeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 21:34:22 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id EE7B8C8ECB; Fri, 29 Feb 2008 03:32:54 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m1T207B8018006;
	Fri, 29 Feb 2008 03:00:07 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m1T206t0018000;
	Fri, 29 Feb 2008 03:00:06 +0100
In-reply-to: <200802280453.11446.chriscool@tuxfamily.org> (message from
	Christian Couder on Thu, 28 Feb 2008 04:53:11 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.4,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -2.60,
	SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75499>


   Le jeudi 28 f=E9vrier 2008, Xavier Maillard a =E9crit :
   >    Note that "emacsclient" is used with option "-e" to launch "wom=
an"
   >    on emacs and this works only on versions >=3D 22.
   >
   > Although reading the code, I find it nicely done, it wouldn't
   > apply on my current git repository without modifications.
   >
   > Did you rebase your work before your patch submission ?

   Yes, it was rebased on the 'next' branch.

Ok that explains why I could not apply it here :) I have switched
to the 'net' branch and it effectively applied.

	Xavier
--=20
http://www.gnu.org
http://www.april.org
http://www.lolica.org
