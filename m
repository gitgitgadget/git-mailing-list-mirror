From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] git-blame.el: show the when, who and what in the minibuffer.
Date: Thu, 14 Feb 2008 03:00:09 +0100
Organization: GNU's Not UNIX!
Message-ID: <200802140200.m1E20996005980@localhost.localdomain>
References: <87ve4vo7g4.dancerj%dancer@netfort.gr.jp>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: git@vger.kernel.org, zedek@gnu.org, davidk@lysator.liu.se
To: Junichi Uekawa <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Thu Feb 14 03:03:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPTRD-0004Ga-LM
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 03:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbYBNCCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 21:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbYBNCCI
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 21:02:08 -0500
Received: from master.uucpssh.org ([193.218.105.66]:38554 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYBNCCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 21:02:07 -0500
X-Greylist: delayed 1790 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2008 21:02:07 EST
Received: by master.uucpssh.org (Postfix, from userid 10)
	id DED14C7032; Thu, 14 Feb 2008 02:31:20 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m1E20EGZ005993;
	Thu, 14 Feb 2008 03:00:15 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m1E20996005980;
	Thu, 14 Feb 2008 03:00:09 +0100
In-reply-to: <87ve4vo7g4.dancerj%dancer@netfort.gr.jp> (message from Junichi
	Uekawa on Tue, 12 Feb 2008 00:00:07 +0900)
User-Agent: Rmail in GNU Emacs 23.0.60.3 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.383,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.02,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73841>

Hi,

   Change the default operation to show 'when (day the commit was made),
   who (who made the commit), what (what the commit log was)' in the
   minibuffer instead of SHA1 and title of the commit log.

Love this even more with the user configurable option.

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
