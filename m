From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Fri, 22 Feb 2008 03:00:03 +0100
Organization: GNU's Not UNIX!
Message-ID: <200802220200.m1M203f3003434@localhost.localdomain>
References: <87odaa4tcl.fsf@lysator.liu.se>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: julliard@winehq.org, git@vger.kernel.org
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 22 03:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSNk2-0003do-Er
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 03:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881AbYBVCdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 21:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754648AbYBVCdu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 21:33:50 -0500
Received: from master.uucpssh.org ([193.218.105.66]:48550 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbYBVCdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 21:33:49 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id ABBA6C5750; Fri, 22 Feb 2008 03:32:13 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m1M204i7003437;
	Fri, 22 Feb 2008 03:00:04 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m1M203f3003434;
	Fri, 22 Feb 2008 03:00:03 +0100
In-reply-to: <87odaa4tcl.fsf@lysator.liu.se> (message from
	=?utf-8?Q?David_K=C3=A5gedal?= on Tue, 19 Feb 2008 14:03:18 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.355,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.04,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74689>

   This allows easy access to git grep from Emacs.

Very useful. Would it be possible to save the history from
sessions to sessions ?

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
