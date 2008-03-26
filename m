From: Xavier Maillard <xma@gnu.org>
Subject: git diff odds
Date: Wed, 26 Mar 2008 02:00:59 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803260100.m2Q10v2l005189@localhost.localdomain>
Reply-To: Xavier Maillard <xma@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 02:40:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeKcd-0005Oo-0W
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 02:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760070AbYCZBjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 21:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760035AbYCZBja
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 21:39:30 -0400
Received: from master.uucpssh.org ([193.218.105.66]:37437 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759991AbYCZBj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 21:39:29 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 51103D653B; Wed, 26 Mar 2008 02:36:20 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2Q11DOB005231
	for <git@vger.kernel.org>; Wed, 26 Mar 2008 02:01:13 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2Q10v2l005189;
	Wed, 26 Mar 2008 02:00:59 +0100
User-Agent: Rmail in GNU Emacs 23.0.60.3 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.224,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.18,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78240>

Hi,

With LESS variable set as "-M", git diff displays escape sequence
instead of the colored ouput (as requested in my .git/config =>
color.diff=auto). If set to FRSX, it works perfectly.

Is this a bug ?

Regards,

	Xavier

P.S: I am unsubscribing from this list (too many messages) so
please keep me in the Cc to respond. Thank you.
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
