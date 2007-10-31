From: Pascal Obry <pascal@obry.net>
Subject: Re: How to remove a specific hunk
Date: Wed, 31 Oct 2007 13:24:58 +0100
Organization: Home - http://www.obry.net
Message-ID: <4728741A.90503@obry.net>
References: <4722036E.5030204@wanadoo.fr> <20071026192034.GA3062@steel.home>	<13D08D3F-3647-4E20-AF80-8EC6FD14E66A@lrde.epita.fr>	<Pine.LNX.4.64.0710311104450.4362@racer.site> <82zlxzsdkf.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>,
	Alex Riesen <raa.lkml@gmail.com>,
	git list <git@vger.kernel.org>
To: Florian Weimer <fweimer@bfk.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InCdK-0002Lj-MA
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 13:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbXJaMZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 08:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753721AbXJaMZE
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 08:25:04 -0400
Received: from smtp2e.orange.fr ([80.12.242.113]:22023 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbXJaMZC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 08:25:02 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e17.orange.fr (SMTP Server) with ESMTP id DB198700009B
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 13:24:59 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-98-100.w90-35.abo.wanadoo.fr [90.35.16.100])
	by mwinf2e17.orange.fr (SMTP Server) with ESMTP id 7369A70000A0;
	Wed, 31 Oct 2007 13:24:59 +0100 (CET)
X-ME-UUID: 20071031122459472.7369A70000A0@mwinf2e17.orange.fr
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <82zlxzsdkf.fsf@mid.bfk.de>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62822>

=46lorian Weimer a =E9crit :
> I think Benoit wants to remove it from the working copy (and,
> presumably, the index too).  "Revert hunk" and "Move hunk to stash"
> might indeed be useful additions to citool.

That was not Benoit but me who asked this question. I want indeed the
hunk to be reverted/removed on the working copy. I had many answers to
do this but I still think a "git reset --interactive" with the
possibility to revert some hunks would be easier.

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
