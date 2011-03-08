From: "Hillel (Sabba) Markowitz" <sabbahillel@gmail.com>
Subject: Re: gitosis configuration question
Date: Tue, 8 Mar 2011 16:51:12 -0500
Message-ID: <AANLkTin1weByGkd_2X474hjGP9nxX8SnNM3ComK-e_Ms@mail.gmail.com>
References: <AANLkTik1WFacXcxrWP3RQ26rXCaQphT1H-CAwKEz6Gx8@mail.gmail.com>
	<1299616032.20004.2.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4oY-0003qT-Gb
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153Ab1CHVvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 16:51:16 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65271 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756644Ab1CHVvN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 16:51:13 -0500
Received: by gxk8 with SMTP id 8so2154263gxk.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 13:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iCgnjkKFRZixf48bYsUXns7WsRFZ5PB/o5qOF8a+Dts=;
        b=oFZ7Uggb79qamk7OUUlpvfxxf0UbUvQBI/f7GKLcdvbBlGkVTiDmOURCMMlOVTU6LO
         BQLBFn60zViWXb/9Cr5G50NTXVzy3U/jJAL+r4DjOoLqjrMBf15/rmPVaR5UR1w4Y1Uw
         S9tKw8WnO6k+LwUwZNhrDgiLGt4j5vYxiinJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rh2YqHeOSvz4NPcEEsvdwJz3JDdvQRzmkMIFEK1KffuHrUkeWOt/HDvjBze1QJYLP6
         UTN5hEOC7+Xsnx74SHZjvS8XCUdA1E33PqPlXpGeceXj7g4mKWvWQx1vkzZFXIw8l51h
         6HxbB0HfOPgAmEZd06tbeBpe6ary2qsaWhk2o=
Received: by 10.101.108.17 with SMTP id k17mr2321724anm.128.1299621072091;
 Tue, 08 Mar 2011 13:51:12 -0800 (PST)
Received: by 10.101.45.6 with HTTP; Tue, 8 Mar 2011 13:51:12 -0800 (PST)
In-Reply-To: <1299616032.20004.2.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168705>

On Tue, Mar 8, 2011 at 3:27 PM, Drew Northup <drew.northup@maine.edu> w=
rote:
>
> On Tue, 2011-03-08 at 13:46 -0500, Hillel (Sabba) Markowitz wrote:
> > When setting up gitosis, I want to have multiple repos available fo=
r a
> > particular group. However, the list of repos is too big for a singl=
e
> > line. The example.conf does not indicate if this is allowed. =C2=A0=
That is,
> > the example that it gives is
>
> Hillel,
> Gitosis is basically no longer supported...
>
> For Reference:
> http://article.gmane.org/gmane.comp.version-control.git/160230
>
> I hope this helps!
>
> --
> -Drew Northup
> ________________________________________________
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
>

Thanks. I had not been aware that it had been replaced with gitolite.
I will have to look it up and see what is available.

--
=C2=A0 =C2=A0 =C2=A0=C2=A0 Sabba=C2=A0 =C2=A0=C2=A0 -=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =D7=A1=D7=91=D7=90 =D7=94=D7=9C=D7=9C=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -=C2=A0 =C2=A0=C2=A0 Hillel
Hillel (Sabba) Markowitz | Said the fox to the fish, "Join me ashore"
=C2=A0SabbaHillel@gmail.com | The fish are the Jews, Torah is our water
http://sabbahillel.blogspot.com
