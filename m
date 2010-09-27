From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Splitting the mailing list up
Date: Mon, 27 Sep 2010 18:53:56 +0200
Message-ID: <20100927165356.GA13032@vidovic>
References: <20100925230022.6e2fd389.coolzone@it.dk>
 <AANLkTikXSfO0uGP1b20jkF09=Mfq0s0+4d4_ANeprXF_@mail.gmail.com>
 <8AE74FC9-6C7F-433E-A162-E56644847198@wincent.com>
 <AANLkTik3ES08H1VSaGxv7aDoV3Ki_Y2ea2dHYqem0S28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Sebastien Douche <sdouche@gmail.com>,
	Rico Secada <coolzone@it.dk>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:54:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Gxu-0004Y0-RE
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067Ab0I0QyF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 12:54:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47260 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0I0QyE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:54:04 -0400
Received: by wyb28 with SMTP id 28so4059069wyb.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IsY0/zLZy/pDjMcOqWV+LyUfBd/M6PxgXUYxcwsZYY4=;
        b=s6jpAyy4MIeliWLNExl1/EbWY4kKQulwdMMNHW2Kk4qoLgnzCJ9Z8DB96PPIoPiyOm
         eCuI4hJHKtbCTDxuWpzEHYL8rNTJAEAfni6ocMCoZ/ZrfPyGSBR2jo+vzXdH1i9srjat
         XSE/mcOgnqHrj7ONDTdsOGBBy3DNTE19xWehY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JpwrrJ3WKayNyxLkmUXV1fh5TGJvB0VON6owfIMjlsnq0xVqz/BQs4ctBWg58hD05u
         eT7cFxofqJmSaOfbEn6ug4PUNecaM0dnnWq7UCA0TqlkpNwdCWKmnQkcqUf8zCWa0qa2
         LusaR90WdbLdiM7pwFLHHj+U9xnjbQ61xtNHA=
Received: by 10.216.17.207 with SMTP id j57mr13101389wej.68.1285606441876;
        Mon, 27 Sep 2010 09:54:01 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id w14sm3758812weq.33.2010.09.27.09.53.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 09:54:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik3ES08H1VSaGxv7aDoV3Ki_Y2ea2dHYqem0S28@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157355>

The 26/09/10, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> Right, but for the *main* mailing list. However if Rico, Walter and
> others would find a limited traffic mailing list valuable there's
> nothing stopping them from setting one up.
>=20
> Jay linked to an archive where someone is running RSS feeds of the
> different parts of the git list, similarly you could set up a git-use=
r
> list which would be a version of the git list filtered to reduce patc=
h
> traffic.
>=20
> Maybe that list wouldn't make much sense when patches are intermingle=
d
> with regular discussion, but it's worth a try.

zsh mailing lists(1) are splitted in users and workers where submission=
s
in the users list are forwarded to workers. This looks like a good
solution for the git mailing list(s), IMHO.

1. http://zsh.sourceforge.net/Arc/mlist.html

--=20
Nicolas Sebrecht
