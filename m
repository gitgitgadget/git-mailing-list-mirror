From: Pascal Obry <pascal.obry@wanadoo.fr>
Subject: How to remove a specific hunk
Date: Fri, 26 Oct 2007 17:10:38 +0200
Organization: Home
Message-ID: <4722036E.5030204@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:17:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlQw8-0006Q7-Sc
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 17:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbXJZPRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 11:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbXJZPRM
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 11:17:12 -0400
Received: from smtp23.orange.fr ([80.12.242.97]:29674 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbXJZPRM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 11:17:12 -0400
Received: from smtp23.orange.fr (mwinf2351 [10.232.4.151])
	by mwinf2310.orange.fr (SMTP Server) with ESMTP id DC8E01C26209
	for <git@vger.kernel.org>; Fri, 26 Oct 2007 17:11:22 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2351.orange.fr (SMTP Server) with ESMTP id 019B71C00084
	for <git@vger.kernel.org>; Fri, 26 Oct 2007 17:10:41 +0200 (CEST)
Received: from [192.168.0.100] (AVelizy-151-1-88-36.w86-205.abo.wanadoo.fr [86.205.126.36])
	by mwinf2351.orange.fr (SMTP Server) with ESMTP id B99A31C0009B
	for <git@vger.kernel.org>; Fri, 26 Oct 2007 17:10:40 +0200 (CEST)
X-ME-UUID: 20071026151040760.B99A31C0009B@mwinf2351.orange.fr
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62415>


Hello,

I'm very new to Git... but start to love it :)

Before committing sometimes I want to remove a specific hunk. Say in
file a.txt I have in the diff 3 hunks, I want to revert/delete/remove
the second one. Is there a way to do that ?

I understand that I can git add interactive and select the hook I want
to commit, but this is not fully equivalent. I'm not yet ready to commit
I just want to undo a specific change and test the code without it...

Any idea ?

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
