From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git, Parrot, Perl6, Rakudo for G4 MAC
Date: Tue, 15 Nov 2011 10:12:11 -0800 (PST)
Message-ID: <m3fwhpmf1f.fsf@localhost.localdomain>
References: <loom.20111115T112500-386@post.gmane.org>
	<CAE1pOi0fqzoz+Af8PaSORuW45UqDAEmqtKW3w4qYH-275BdUzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg <greggallen@gmail.com>, git@vger.kernel.org
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 19:12:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQNUZ-00083e-63
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 19:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891Ab1KOSMO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 13:12:14 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62947 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab1KOSMN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 13:12:13 -0500
Received: by bke11 with SMTP id 11so7434404bke.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 10:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=1Q5ChaxbXvfqgqoMvq44Ur3F+pu2gOl81YWO5WUyqbE=;
        b=lX95ck8jcMiKQu73KHZH5k+SC6o68dDq4ZDL9q0aronSuURmnl/rF8EIc2Z/JACHu2
         of5dgh662NtgyfjIBlRwRttblqBIjpuZaSYtJuYl8GyJKLWXr/VtwYKonHteiyFKzV6+
         q5ABO6cAK/3iDGtvE8OARI3odoFYDdObwkEKE=
Received: by 10.204.41.66 with SMTP id n2mr25119312bke.77.1321380732415;
        Tue, 15 Nov 2011 10:12:12 -0800 (PST)
Received: from localhost.localdomain (abwr71.neoplus.adsl.tpnet.pl. [83.8.241.71])
        by mx.google.com with ESMTPS id q16sm2773444fae.6.2011.11.15.10.12.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 10:12:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pAFIBpKF018507;
	Tue, 15 Nov 2011 19:11:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pAFIBerT018503;
	Tue, 15 Nov 2011 19:11:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAE1pOi0fqzoz+Af8PaSORuW45UqDAEmqtKW3w4qYH-275BdUzw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185477>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
> On 15 November 2011 02:36, Greg <greggallen@gmail.com> wrote:

> > Could someone please assist me in locating the resources to "GIT"
> > =A0this stuff going on a G4 MAC PPC? =A0I
> > keep getting weird bugs.
> > Need me to be more explicit? =A0Ok - it says gcc v3.3 isn't compati=
ble, and a
> > bunch of other sheet!

Yes, you need to be more explicit.  Please copy'n'paste exact error
messages that you get compiling Git.

>=20
> GCC 3.3 is from May 2003, I suggest you upgrade to a more recent GCC
> (probably 4.6).

I don't have experience compiling Git for PPC, but on i386 I can
compile Git without problems with gcc 4.0.2.
=20
> > I already have Perl5.10.1 working fine, and performing
> > numerous marvelous tasks, so I (perhaps
> > mistakenly) thought it would be an easy addition.
>=20
> Perl 5.10.1 is from August 2009. Presumably less of a problem but,
> again, you should probably upgrade to something more recent.

Git requires Perl version 5.8 at least, so you should not have any
problems here.
=20
--=20
Jakub Nar=EAbski
