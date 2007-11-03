From: Pascal Obry <pascal@obry.net>
Subject: git-svn, tracking branches
Date: Sat, 03 Nov 2007 12:16:37 +0100
Organization: Home - http://www.obry.net
Message-ID: <472C5895.4050100@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 12:17:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoGzx-0001tx-3p
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbXKCLQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbXKCLQv
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:16:51 -0400
Received: from smtp2b.orange.fr ([80.12.242.145]:55467 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbXKCLQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:16:50 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b07.orange.fr (SMTP Server) with ESMTP id 971FF7000092
	for <git@vger.kernel.org>; Sat,  3 Nov 2007 12:16:48 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-56-12.w82-120.abo.wanadoo.fr [82.120.25.12])
	by mwinf2b07.orange.fr (SMTP Server) with ESMTP id 201687000089
	for <git@vger.kernel.org>; Sat,  3 Nov 2007 12:16:46 +0100 (CET)
X-ME-UUID: 20071103111647131.201687000089@mwinf2b07.orange.fr
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63233>


Hi there,

I have "git svn init" a repository to work only on the trunk for the
Subversion repository. I'd like now to work on a branch. I've been able
to do that by editing .git/config, no problem.

My question, is there a better way than hand editing this file ? I've
tried "git remote" but it seems to work only for git repo and there is
no "git svn remote"... Any idea ?

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
