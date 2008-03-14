From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] Documentation: help: explain 'man.viewer' multiple values
Date: Fri, 14 Mar 2008 02:00:07 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803140100.m2E107Zl004673@localhost.localdomain>
References: <20080313064846.b6b54c11.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 02:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZyqW-0001OA-9K
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 02:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbYCNBfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 21:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbYCNBfz
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 21:35:55 -0400
Received: from master.uucpssh.org ([193.218.105.66]:36309 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbYCNBfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 21:35:50 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id EBB69D3DBD; Fri, 14 Mar 2008 02:34:19 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2E10Cnc004681;
	Fri, 14 Mar 2008 02:00:13 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2E107Zl004673;
	Fri, 14 Mar 2008 02:00:07 +0100
In-reply-to: <20080313064846.b6b54c11.chriscool@tuxfamily.org> (message from
	Christian Couder on Thu, 13 Mar 2008 06:48:46 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.39,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.01,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77162>


   Also add titles to paragraphs under "CONFIGURATION VARIABLES".

   Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

<snip>

    man.viewer::
   -	Specify the program that will be used to display help in the
   +	Specify the programs that may be used to display help in the

I would have prefered the following wording:

"List of viewer candidates used to display help in"

   +If everythings fails the 'man' program will be tried anyway.
       ^^^^^^^^^^^
everything :)

Regards

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
