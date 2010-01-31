From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [ANNOUNCE] Git 1.7.0.rc1
Date: Sun, 31 Jan 2010 09:56:32 +0200
Message-ID: <20100131075632.GA30470@Knoppix>
References: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001301712h3223f4c5xcf4742cde1642dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 09:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbUjL-0004qU-Cf
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 09:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab0AaH4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 02:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867Ab0AaH4j
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 02:56:39 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:52917 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab0AaH4i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 02:56:38 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 1DAAF13BE78;
	Sun, 31 Jan 2010 09:56:37 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A048991BB50; Sun, 31 Jan 2010 09:56:37 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 007F041BF1;
	Sun, 31 Jan 2010 09:56:32 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <fabb9a1e1001301712h3223f4c5xcf4742cde1642dfe@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138532>

On Sun, Jan 31, 2010 at 02:12:19AM +0100, Sverre Rabbelier wrote:
> Heya,
>=20
> Feel free to tell me "go build 1.7.0.rc0 yourself and see" to any of
> these, but I can't right now, and am curious :).
>=20
> > =C2=A0* "git log" and friends learned "--glob=3Dheads/*" syntax tha=
t is a more
> > =C2=A0 flexible way to complement "--branches/--tags/--remotes".
>=20
> Not --glob=3Drefs/*?

That does work. Even shorter would be '--glob=3D*'.

-Ilari
