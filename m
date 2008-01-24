From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Thu, 24 Jan 2008 19:16:07 +0100
Organization: Home - http://www.obry.net
Message-ID: <4798D5E7.8070907@obry.net>
References: <1201198439-3516-1-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Jan 24 19:16:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6d1-0006WB-HK
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbYAXSQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 13:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbYAXSQN
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:16:13 -0500
Received: from smtp2b.orange.fr ([80.12.242.145]:17733 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881AbYAXSQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:16:12 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b13.orange.fr (SMTP Server) with ESMTP id 799597000349
	for <git@vger.kernel.org>; Thu, 24 Jan 2008 19:16:10 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-7-190.w82-120.abo.wanadoo.fr [82.120.149.190])
	by mwinf2b13.orange.fr (SMTP Server) with ESMTP id 2BEC770002BB;
	Thu, 24 Jan 2008 19:16:10 +0100 (CET)
X-ME-UUID: 20080124181610179.2BEC770002BB@mwinf2b13.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <1201198439-3516-1-git-send-email-pascal@obry.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71640>


Typing too fast I've just made this mistake the third time today. It is 
of course easy to revert but a check seems appropriate here.

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
