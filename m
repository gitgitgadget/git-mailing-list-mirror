From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Tue, 18 Dec 2007 17:54:15 +0100
Organization: Home - http://www.obry.net
Message-ID: <4767FB37.2030505@obry.net>
References: <1197992574-3464-1-git-send-email-pascal@obry.net> <4767ED52.9010004@viscovery.net> <4767EE6D.5070509@obry.net> <alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fiv-0006Zt-Sw
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760897AbXLRQyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759695AbXLRQyX
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:54:23 -0500
Received: from smtp27.orange.fr ([80.12.242.96]:32936 "EHLO smtp27.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760888AbXLRQyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:54:21 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2718.orange.fr (SMTP Server) with ESMTP id 26C401C000C2
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 17:54:19 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-60-249.w82-124.abo.wanadoo.fr [82.124.126.249])
	by mwinf2718.orange.fr (SMTP Server) with ESMTP id 8F5851C00082;
	Tue, 18 Dec 2007 17:54:18 +0100 (CET)
X-ME-UUID: 20071218165418587.8F5851C00082@mwinf2718.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68781>

Linus Torvalds a =C3=A9crit :
>   --src-prefix=3D<string>		// default "a/"
>   --dst-prefix=3D<string>		// default "b/"
>   --no-prefix			// shorthand for --src-prefix=3D"" --dst-prefix=3D""
>=20
> would work for everybody?

=46ine with me.

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
