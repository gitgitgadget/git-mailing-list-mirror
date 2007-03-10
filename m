From: Xavier Maillard <zedek@gnu.org>
Subject: Re: git-cvsimport: all my files are marked deleted ?
Date: Sat, 10 Mar 2007 20:37:34 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703101937.l2AJbYtn007143@localhost.localdomain>
References: <200703101809.l2AI9lin005409@localhost.localdomain> <1173552693.5975.13.camel@localhost>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 20:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ7Qp-00064W-4I
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 20:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbXCJTkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 14:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbXCJTkf
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 14:40:35 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:60406 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117AbXCJTkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 14:40:35 -0500
Received: from zogzog.home (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id EA9897DC3;
	Sat, 10 Mar 2007 20:40:33 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l2AJbZUe007146;
	Sat, 10 Mar 2007 20:37:35 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2AJbYtn007143;
	Sat, 10 Mar 2007 20:37:34 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <1173552693.5975.13.camel@localhost> (ray007@gmx.net)
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41883>

   From: Raimund Bauer <ray007@gmx.net>

   On Sat, 2007-03-10 at 19:09 +0100, Xavier Maillard wrote:
   > Then I went back to <directory> and I just did 'ls'. Directory is
   > empty (except the .git directory).

   'git checkout -f' is your friend here.

   Not long ago I was wondering about the same thing ...

Oh great ! You are my safer !

-- 
Xavier
