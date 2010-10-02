From: Pascal Obry <pascal@obry.net>
Subject: Re: What's cooking in git.git (Sep 2010, #07; Wed, 29)
Date: Sat, 02 Oct 2010 10:12:49 +0200
Organization: Home - http://www.obry.net
Message-ID: <4CA6E981.7050804@obry.net>
References: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:12:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xCz-0007Fi-Jp
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab0JBIMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:12:35 -0400
Received: from smtp2a.orange.fr ([80.12.242.138]:7359 "EHLO smtp2a.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507Ab0JBIMd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:12:33 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2a01.orange.fr (SMTP Server) with ESMTP id 1A5CC8000298;
	Sat,  2 Oct 2010 10:12:32 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2a01.orange.fr (SMTP Server) with ESMTP id 0C53B800029C;
	Sat,  2 Oct 2010 10:12:32 +0200 (CEST)
Received: from [192.168.0.100] (AVelizy-154-1-80-87.w86-205.abo.wanadoo.fr [86.205.110.87])
	by mwinf2a01.orange.fr (SMTP Server) with ESMTP id CF6048000298;
	Sat,  2 Oct 2010 10:12:31 +0200 (CEST)
X-ME-UUID: 20101002081231849.CF6048000298@mwinf2a01.orange.fr
X-ME-User-Auth: pascal.obry
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157794>

Junio,

> * po/sendemail (2010-09-06) 3 commits
>   (merged to 'next' on 2010-09-22 at 1105f62)
>  + New send-email option smtpserveroption.
>  + Remove @smtp_host_parts variable as not used.
>  + Minor indentation fix.
> 
> Comments from potential users?

Well don't know if I qualify as a potential user as I'm the author of
this patch-set but I can tell that I'm using this since some time now
without trouble on my side. I'm eagerly waiting to see this graduated to
master :)

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
