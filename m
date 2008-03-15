From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] help: implement multi-valued "man.viewer" config option
Date: Sat, 15 Mar 2008 14:00:27 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803151300.m2FD0RHF003225@localhost.localdomain>
References: <20080311085113.176df1af.chriscool@tuxfamily.org> <200803120823.38100.chriscool@tuxfamily.org> <200803140100.m2E105o5004664@localhost.localdomain> <200803140626.16075.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 14:09:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaW84-0003KF-80
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 14:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYCONHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 09:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbYCONHv
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 09:07:51 -0400
Received: from master.uucpssh.org ([193.218.105.66]:54352 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbYCONHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 09:07:45 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 3C549C6497; Sat, 15 Mar 2008 14:05:42 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2FD0TcB003228;
	Sat, 15 Mar 2008 14:00:29 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2FD0RHF003225;
	Sat, 15 Mar 2008 14:00:27 +0100
In-reply-to: <200803140626.16075.chriscool@tuxfamily.org> (message from
	Christian Couder on Fri, 14 Mar 2008 06:26:15 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, timed out)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77329>


   >    I will do that in a latter patch, it has been suggested a lot of times
   >    already.
   >
   > Glad to read that !

   I just sent a patch to do that in "git-web--browse.sh" and I will soon work 
   on the same stuff for man viewing.

Seen it and I am about to test it ;)

   > Well, I do not buy this argument and I am pretty sure that a
   > simple note into the manual would suffice but, that's me :)

   As my patch is now on next and as I am not sure to understand exactly what 
   you want, I can only suggest to send a patch if you really care.

I could but I won't: no time and most importantly, who really
care except me ? :) It is okay for me as is (I can certainly live
with that).

Regards

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
