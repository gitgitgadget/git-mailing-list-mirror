From: Yann Droneaud <yann@droneaud.fr>
Subject: Re: wishlist: git send-email improvement
Date: Sat, 13 Mar 2010 14:06:54 +0100
Message-ID: <1268485614.7884.0.camel@localhost>
References: <1268155306.4277.14.camel@localhost>
	 <7veijtz9kn.fsf@alter.siamese.dyndns.org>
	 <1268156947.4277.26.camel@localhost> <1268157314.4277.30.camel@localhost>
	 <4B96A1ED.3020809@sysvalve.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "\"L. Alberto" =?ISO-8859-1?Q?Gim=E9nez=22?= 
	<agimenez-git@sysvalve.homelinux.net>
X-From: git-owner@vger.kernel.org Sat Mar 13 14:07:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqR3k-0006Os-Ks
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 14:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759167Ab0CMNHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Mar 2010 08:07:08 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:54954 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759142Ab0CMNHG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Mar 2010 08:07:06 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 991D24C80CD;
	Sat, 13 Mar 2010 14:06:58 +0100 (CET)
Received: from mais.quest-ce.net (mais.quest-ce.net [88.161.129.79])
	by smtp4-g21.free.fr (Postfix) with ESMTP id B7E834C8092;
	Sat, 13 Mar 2010 14:06:55 +0100 (CET)
Received: by mais.quest-ce.net (Postfix, from userid 500)
	id 4A4CB7C061; Sat, 13 Mar 2010 14:06:55 +0100 (CET)
In-Reply-To: <4B96A1ED.3020809@sysvalve.homelinux.net>
X-Mailer: Evolution 2.26.3-1.1mdv2009.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142098>

Le mardi 09 mars 2010 =C3=A0 20:30 +0100, "L. Alberto Gim=C3=A9nez" a =C3=
=A9crit :
> On 03/09/2010 06:55 PM, Yann Droneaud wrote:
> > Le mardi 09 mars 2010 =C3=A0 18:49 +0100, Yann Droneaud a =C3=A9cri=
t :
> >> Perhaps I should learn to use git send-email --from instead.
> >=20
> > Sadly, it appends the From: field extracted from file to the Cc: li=
st :/
> >=20
> > So I still have to manually fix the mbox file before using git
> > send-email.
>=20
> Hi,
>=20
> Have you tried --suppress-from?
>=20
[...]
> I'm not sure if it's what you need, but it seems to be.
>=20

Tested and approved.=20
Thanks for the trick.

Regards.

--=20
Yann Droneaud
