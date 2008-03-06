From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] run-command: Redirect stderr to a pipe before redirecting
 stdout to stderr
Date: Thu, 6 Mar 2008 02:00:05 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803060100.m26104Vx004182@localhost.localdomain>
References: <20080305083516.e1a2a139.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: gitster@pobox.com, spearce@spearce.org, j.sixt@viscovery.net,
	git@vger.kernel.org, nanako3@bluebottle.com, pascal@obry.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 02:35:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX51C-0006IN-U8
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 02:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760258AbYCFBe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 20:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760066AbYCFBe4
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 20:34:56 -0500
Received: from master.uucpssh.org ([193.218.105.66]:41850 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758729AbYCFBez (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 20:34:55 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id D33C5C950F; Thu,  6 Mar 2008 02:33:39 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m26107Cd004186;
	Thu, 6 Mar 2008 02:00:07 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m26104Vx004182;
	Thu, 6 Mar 2008 02:00:05 +0100
In-reply-to: <20080305083516.e1a2a139.chriscool@tuxfamily.org> (message from
	Christian Couder on Wed, 5 Mar 2008 08:35:16 +0100)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76305>


   Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Tested successfully.

Acked-by: Xavier Maillard <xma@gnu.org>

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
