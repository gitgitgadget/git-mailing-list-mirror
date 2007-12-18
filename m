From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Tue, 18 Dec 2007 17:11:49 +0100
Organization: Home - http://www.obry.net
Message-ID: <4767F145.3030109@obry.net>
References: <1197992574-3464-1-git-send-email-pascal@obry.net> <4767EF5B.3010600@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4f3I-0004U6-Ve
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757063AbXLRQLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 11:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbXLRQLy
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:11:54 -0500
Received: from smtp28.orange.fr ([80.12.242.100]:37544 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbXLRQLx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:11:53 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2813.orange.fr (SMTP Server) with ESMTP id 0E6A770000A7
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 17:11:52 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-60-249.w82-124.abo.wanadoo.fr [82.124.126.249])
	by mwinf2813.orange.fr (SMTP Server) with ESMTP id BC8357000091;
	Tue, 18 Dec 2007 17:11:51 +0100 (CET)
X-ME-UUID: 20071218161151772.BC8357000091@mwinf2813.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <4767EF5B.3010600@op5.se>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68771>

Andreas Ericsson a =E9crit :
> Pascal Obry wrote:
>>      int thread =3D 0;
>> +    int no_name_prefix =3D 0;
>=20
> Do we not need no double negations, yes?

Not sure, looks clearer to use variable name corresponding to the optio=
n
name to me...

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
