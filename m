From: Pascal Obry <pascal@obry.net>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 10:33:08 +0100
Organization: Home - http://www.obry.net
Message-ID: <47284BD4.5050904@obry.net>
References: <20071030053732.GA16963@hermes.priv> <fg8h9l$b4n$1@ger.gmane.org> <20071031013856.GA23274@coredump.intra.peff.net> <200710310249.17233.jnareb@gmail.com> <20071031015708.GA24403@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 10:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In9x7-0005U0-Bk
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 10:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbXJaJdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 05:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbXJaJdR
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 05:33:17 -0400
Received: from smtp27.orange.fr ([80.12.242.95]:6862 "EHLO smtp27.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754016AbXJaJdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 05:33:16 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2713.orange.fr (SMTP Server) with ESMTP id 745D31C0021D
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 10:33:15 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-98-100.w90-35.abo.wanadoo.fr [90.35.16.100])
	by mwinf2713.orange.fr (SMTP Server) with ESMTP id 39E7C1C001E7;
	Wed, 31 Oct 2007 10:33:15 +0100 (CET)
X-ME-UUID: 20071031093315237.39E7C1C001E7@mwinf2713.orange.fr
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071031015708.GA24403@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff King a =E9crit :
>   'http://foo.tld/url with a space'
>=20
> rather than:
>=20
>   http://foo.tld/url+with+a+space
>=20
> ?
>=20
> I think the latter is much more common, if only because of the fact t=
hat
> copy and paste from most browsers' location bars gives the encoded
> version.

I agree 100%. It is the more common as it follows the standard encoding=
=2E

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
