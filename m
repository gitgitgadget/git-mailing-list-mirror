From: Xavier Maillard <xma@gnu.org>
Subject: Re: When to repack?
Date: Sat, 1 Mar 2008 02:00:16 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803010100.m2110GSw008865@localhost.localdomain>
References: <47C7E4AD.6030509@glidos.net>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: git@vger.kernel.org, osronline@glidos.net
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 02:35:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVGcw-0001az-4z
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 02:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbYCABeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 20:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbYCABeZ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 20:34:25 -0500
Received: from master.uucpssh.org ([193.218.105.66]:49911 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964AbYCABeY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 20:34:24 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 5A7E2C9350; Sat,  1 Mar 2008 02:33:01 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2110StM008887;
	Sat, 1 Mar 2008 02:00:28 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2110GSw008865;
	Sat, 1 Mar 2008 02:00:16 +0100
In-reply-to: <47C7E4AD.6030509@glidos.net> (message from Paul Gardiner on Fri,
	29 Feb 2008 10:55:41 +0000)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.4,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.00,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75598>


   There's advantage to repacking a repository after using git-fast-import.
   If that repacked repository is then git-pushed to another, is there
   any point in repacking the other afterwards? I'm guessing not, but
   just checking.

I am not an expert but I would not do it afterwards too.


	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
