From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Applicatioin of contribution for Git Chinese version
Date: Sat, 16 Apr 2011 10:22:42 -0700 (PDT)
Message-ID: <m362qexgb1.fsf@localhost.localdomain>
References: <559debc.6920e.12f5f0bdfc0.Coremail.cyrus_evans@163.com>
	<BANLkTi=29fvnLYVnsjpYXfaB20=H6D6fcg@mail.gmail.com>
	<BANLkTintJ6FsYAQ1iV1kygwOdtsFtCs3EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Cyrus.Evans" <cyrus_evans@163.com>, git <git@vger.kernel.org>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 19:22:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB9Cr-00084I-QH
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 19:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab1DPRWq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 13:22:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48477 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab1DPRWo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2011 13:22:44 -0400
Received: by wya21 with SMTP id 21so2965789wya.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=4efmRtOZ+PT1ceAwXOOAp86qDaaU+ebgFH0jwHuvTyA=;
        b=AHLfPcyqwzA5TrY3QuIuqkWddKD/nGxrak4yGNa8KzeG/cBI8wqiVbaoaCah4cOrEV
         Nsm2k3Chh9KNFW1qTaE03o99LZApFwyUGMcq9UMENVFiVULAbOfuB0NgQrV6cMXuFqW0
         UQFkV5JpArEPsPcuDt3X+RO7AP3EWP6U0RayE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=S1VkoUmy0v1kxBDunrSKK5lptBXmZjpjFjZFpEBYTc3fQaIfLp2wvDnKS+OCdOo040
         5yLyZgKhDYIolJlul2Uos1jB/5XBV9IkXnZu1vrGMTYljoSiCvOh8ixZv0XWbGRzlJbQ
         Cm1NKe7Ryp+xeYCicCTKF22/ENm8CRwVvPb9g=
Received: by 10.216.188.20 with SMTP id z20mr3374717wem.66.1302974563296;
        Sat, 16 Apr 2011 10:22:43 -0700 (PDT)
Received: from localhost.localdomain (abvu151.neoplus.adsl.tpnet.pl [83.8.218.151])
        by mx.google.com with ESMTPS id f30sm1818874wef.7.2011.04.16.10.22.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 10:22:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3GHME2C019304;
	Sat, 16 Apr 2011 19:22:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3GHLtfZ019297;
	Sat, 16 Apr 2011 19:21:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTintJ6FsYAQ1iV1kygwOdtsFtCs3EA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171686>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Apr 16, 2011 at 18:34, =C6var Arnfj=F6r=F0 Bjarmason <avarab@=
gmail.com> wrote:
>=20
> > In particular I was thinking of using some web interface for
> > translation, but that would probably be hard to work out with
> > accounting for who did what, which would play badly with Git's sign=
off
> > policies.
>=20
> It was clear from talking on IRC that having them use PO wouldn't get
> anywhere.
>=20
> So I've created https://translations.launchpad.net/git-i18n
>=20
> It has strings from git's master + the shellscript translations.
>=20
> I've set the translation policy to "open", so anyone can contribute
> there. We can figure out the legal mumbo-jumbo later.
>=20
> Translating there will work once the Launchpad people review & accept
> the POT file I uploaded. I have no idea how long that takes.

Why not use Pootle?

  http://translate.sourceforge.net/wiki/

--=20
Jakub Narebski
Poland
ShadeHawk on #git
