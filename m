From: Pascal Obry <pascal@obry.net>
Subject: Re: Problem with git-svn
Date: Sun, 16 Dec 2007 16:40:07 +0100
Organization: Home - http://www.obry.net
Message-ID: <476546D7.2030805@obry.net>
References: <4764FE2C.1010103@obry.net> <20071216135625.GB4999@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 16 16:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3vbd-00081r-Fv
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 16:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384AbXLPPkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 10:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbXLPPkT
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 10:40:19 -0500
Received: from smtp20.orange.fr ([80.12.242.27]:26778 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012AbXLPPkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 10:40:17 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2008.orange.fr (SMTP Server) with ESMTP id 14ED21C000AA
	for <git@vger.kernel.org>; Sun, 16 Dec 2007 16:40:15 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-60-249.w82-124.abo.wanadoo.fr [82.124.126.249])
	by mwinf2008.orange.fr (SMTP Server) with ESMTP id BE9F51C0009C;
	Sun, 16 Dec 2007 16:40:14 +0100 (CET)
X-ME-UUID: 20071216154014780.BE9F51C0009C@mwinf2008.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071216135625.GB4999@xp.machine.xx>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68462>


Pete,

> Eric made a fix[1] this week so git-svn won't get confused if e.g. trunk
> gets deleted and later created (or e.g. moved). Could you check if it
> also fixes your problem? At least there is some familiarity, because your
> trunk/PROJ also get moved from outside a path git-svn isn't tracking.
> 
> -Peter
> 
> [1]: See this thread for more details
>      http://thread.gmane.org/gmane.comp.version-control.git/67665

This fix is already installed into the Git version I'm using which is:

   git version 1.5.4.rc0.36.g7680

So there is something else...

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
