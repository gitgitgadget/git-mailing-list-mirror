From: Pascal Obry <pascal@obry.net>
Subject: Re: how to create v2 patch
Date: Thu, 06 Dec 2007 22:38:14 +0100
Organization: Home - http://www.obry.net
Message-ID: <47586BC6.2020100@obry.net>
References: <47515693.9070405@imap.cc> <47515EF3.8010507@obry.net> <20071201134321.GA10997@glandium.org> <475855D6.201@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
X-From: git-owner@vger.kernel.org Thu Dec 06 22:38:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0OQf-0000I8-OQ
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 22:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbXLFViU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Dec 2007 16:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbXLFViU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 16:38:20 -0500
Received: from smtp21.orange.fr ([80.12.242.48]:61626 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbXLFViT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 16:38:19 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2116.orange.fr (SMTP Server) with ESMTP id 4B2011C0009F
	for <git@vger.kernel.org>; Thu,  6 Dec 2007 22:38:17 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-88-105.w86-205.abo.wanadoo.fr [86.205.126.105])
	by mwinf2116.orange.fr (SMTP Server) with ESMTP id 057931C00086;
	Thu,  6 Dec 2007 22:38:16 +0100 (CET)
X-ME-UUID: 20071206213817224.057931C00086@mwinf2116.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <475855D6.201@imap.cc>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67340>

Tilman Schmidt a =E9crit :
> Hmm. But wouldn't each of these approaches lead to my original
> commit being removed from my git repository? And isn't removing
> commits that have already been published strongly discouraged?

They won't be removed, just changed/merged... and that's what you were
looking for or I did not understand your question! This is not bad
practice as it is done on YOUR repository. Of course this should never
be done on a pushed/published changeset.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
