From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] git add --interactive: Autoselect single patch file
Date: Fri, 29 Feb 2008 03:00:20 +0100
Organization: GNU's Not UNIX!
Message-ID: <200802290200.m1T20KYS018031@localhost.localdomain>
References: <> <1204197336-615-1-git-send-email-joerg@alea.gnuu.de>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: git@vger.kernel.org, joerg@alea.gnuu.de
To: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Fri Feb 29 03:36:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUv6M-0005wn-5W
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 03:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbYB2Ce3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 21:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbYB2Ce2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 21:34:28 -0500
Received: from master.uucpssh.org ([193.218.105.66]:39144 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253AbYB2CeX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 21:34:23 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id D0360C8F62; Fri, 29 Feb 2008 03:32:54 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m1T20SAZ018053;
	Fri, 29 Feb 2008 03:00:29 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m1T20KYS018031;
	Fri, 29 Feb 2008 03:00:20 +0100
In-reply-to: <1204197336-615-1-git-send-email-joerg@alea.gnuu.de> (message
	from =?utf-8?q?J=C3=B6rg=20Sommer?= on Thu, 28 Feb 2008 12:15:36
	+0100)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75500>


   If there's only one file to patch, select it automaticly and don't bother
   the user. In the case he didn't want do patching, he can say 'd' at the
   patch prompt.

Like this quick-win.

Tested-by: Xavier Maillard <xma@gnu.org>

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
