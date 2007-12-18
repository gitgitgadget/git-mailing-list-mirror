From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Teach diff machinery to display other prefixes than "a/"
 and "b/"
Date: Tue, 18 Dec 2007 20:03:28 +0100
Organization: Home - http://www.obry.net
Message-ID: <47681980.6050603@obry.net>
References: <1197992574-3464-1-git-send-email-pascal@obry.net> <4767ED52.9010004@viscovery.net> <4767EE6D.5070509@obry.net> <alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org> <Pine.LNX.4.64.0712181703560.23902@racer.site> <476809EA.6080608@obry.net> <Pine.LNX.4.64.0712181855020.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:04:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4hjS-0005Wg-Sm
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 20:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbXLRTDc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 14:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbXLRTDc
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 14:03:32 -0500
Received: from smtp2a.orange.fr ([80.12.242.139]:23799 "EHLO smtp2a.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbXLRTDb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 14:03:31 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2a12.orange.fr (SMTP Server) with ESMTP id 30A567000093
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 20:03:30 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-60-249.w82-124.abo.wanadoo.fr [82.124.126.249])
	by mwinf2a12.orange.fr (SMTP Server) with ESMTP id B70B1700008A;
	Tue, 18 Dec 2007 20:03:29 +0100 (CET)
X-ME-UUID: 20071218190329749.B70B1700008A@mwinf2a12.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <Pine.LNX.4.64.0712181855020.23902@racer.site>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68793>

Johannes Schindelin a =E9crit :
> With the new options "--src-prefix <prefix>", "--dst-prefix <prefix>"
> and "--no-prefix", you can now control the path prefixes of the diff
> machinery.  These used to by hardwired to "a/" for the source prefix
> and "b/" for the destination prefix.
>=20
> Initial patch by Pascal Obry.  Sane option names suggested by Linus.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks this looks good to me.

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
