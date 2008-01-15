From: Pascal Obry <pascal@obry.net>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Tue, 15 Jan 2008 18:08:34 +0100
Organization: Home - http://www.obry.net
Message-ID: <478CE892.9070808@obry.net>
References: <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com>	 <20080114202932.GA25130@steel.home> <a5eb9c330801141421g13c627e5x77afb357e2a78463@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEpHm-0004cs-UW
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 18:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbYAORIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2008 12:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYAORIq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 12:08:46 -0500
Received: from smtp2e.orange.fr ([80.12.242.112]:43394 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbYAORIp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 12:08:45 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e06.orange.fr (SMTP Server) with ESMTP id 292A5700009C
	for <git@vger.kernel.org>; Tue, 15 Jan 2008 18:08:41 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-66-40.w81-249.abo.wanadoo.fr [81.249.60.40])
	by mwinf2e06.orange.fr (SMTP Server) with ESMTP id C80DC7000093;
	Tue, 15 Jan 2008 18:08:40 +0100 (CET)
X-ME-UUID: 20080115170840819.C80DC7000093@mwinf2e06.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <a5eb9c330801141421g13c627e5x77afb357e2a78463@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70534>

Paul Umbers a =E9crit :
> The "mount" command tells me everything I have is mounted in binmode.
> I have used Git on a default cygwin install (win XP pro) before and
> not had this problem - that's why this is so frustrating. Not sure
> what changed this time round as I tend to use defaults for most
> installations.
>=20
> Are you saying I need to make sure the repository directory is mounte=
d
> in text-mode (for Windows compatibility)? I just reinstalled cygwin,
> selecting text-mode as the default. I can create a git repository, bu=
t
> "git add ." returns:

Avoid text-mode on Windows with Cygwin. I can't help with your problem=20
but I can tell you that Git is working fine here!

What about permissions for /cygdrive/c/test ?

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
