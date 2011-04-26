From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH] Automatically autoload bashcompinit for ZSH, when
	needed
Date: Tue, 26 Apr 2011 15:52:57 -0500
Message-ID: <1303851177.9740.2.camel@Nokia-N900>
References: <7vtydkddto.fsf@alter.siamese.dyndns.org>
	 <1303849690-20894-1-git-send-email-mstormo@gmail.com>
	  <vpqbozszqnu.fsf@bauges.imag.fr>
Reply-To: Marius Storm-Olsen <marius@storm-olsen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:52:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEpFh-0005H8-4J
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 22:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098Ab1DZUww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 16:52:52 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64977 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586Ab1DZUwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 16:52:51 -0400
Received: by yia27 with SMTP id 27so382748yia.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 13:52:50 -0700 (PDT)
Received: by 10.236.43.75 with SMTP id k51mr1514541yhb.489.1303851170522;
        Tue, 26 Apr 2011 13:52:50 -0700 (PDT)
Received: from [192.168.1.107] (24-155-176-18.dyn.grandenetworks.net [24.155.176.18])
        by mx.google.com with ESMTPS id u29sm47234yhn.70.2011.04.26.13.52.48
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 13:52:49 -0700 (PDT)
X-Mailer: Modest 3.2
In-Reply-To: <vpqbozszqnu.fsf@bauges.imag.fr>
Content-ID: <1303851176.9740.1.camel@Nokia-N900>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172126>

Agreed.

I'm away from my machines right now, so if anyone feels like rerolling =
the patch with that update, that'd be great.

Or Junio could just fix it up when/if picking it.

If not, I'll reroll later tonight.

Thanks!

--=20
=2Emarius @ N900
----- Original message -----
> Marius Storm-Olsen <marius@storm-olsen.com> writes:
>=20
> > -#=C2=A0 =C2=A0 =C2=A0  2) Added the following line to your .bashrc=
:
>=20
> > +#=C2=A0 =C2=A0 =C2=A0  2) Added the following line to your .bashrc=
/.zshrc:
>=20
> While you're there: shouldn't this be "Add", not "Added"?
>=20
> --=20
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
