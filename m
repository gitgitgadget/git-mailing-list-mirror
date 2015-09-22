From: Ray Chen <oldsharp@gmail.com>
Subject: Re: Small mistakes in translation
Date: Tue, 22 Sep 2015 18:01:50 +0800 (CST)
Message-ID: <alpine.DEB.2.20.1509221748520.8738@jagger>
References: <loom.20150922T104305-736@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Przemys=C5=82aw_Skrzyniarz?= <hilarus@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 12:02:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeKOi-0002iZ-5T
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 12:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbbIVKB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 06:01:59 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36531 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757829AbbIVKB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 06:01:57 -0400
Received: by pacgz1 with SMTP id gz1so2641130pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=bU1KFLvIlME71fgHME0HIwLVy4S578EKp/NcX41rQK0=;
        b=0sYreQdiS/6xS1RMOVpMjdzdwv1AWSDxb9Yf0t/442ijsk7oESzYOhTX8hPMIPg7qH
         HO2ndkLPGYjsjcdZKUHTn3OeYcHdgGmjDLc1TuOn9VhTYq4fvQNLjCz7VlljVWc/RLJH
         kbKwZuJ1zyXu4J+XjkyxJrQTA7wv1rAuGru1wDflu7JqHT+quDzs2MyeI7qfRNCqxI9R
         EDJtGyC8rLP7Pj/yCM4uvZpb8FJAWd4VAgnV1PW3NzcdH3D7Pvxtroq3SunYsQpHWFmg
         4GwVJFvrPLHR+ZemB46xqn8+76JbbZpTLeLXXzVmg64iQzVIeC8tbALUQE6e1bIx2meI
         EPQA==
X-Received: by 10.68.226.134 with SMTP id rs6mr30740496pbc.11.1442916116760;
        Tue, 22 Sep 2015 03:01:56 -0700 (PDT)
Received: from 127.0.0.1 (li83-216.members.linode.com. [74.207.241.216])
        by smtp.gmail.com with ESMTPSA id kw10sm1331378pbc.25.2015.09.22.03.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2015 03:01:55 -0700 (PDT)
In-Reply-To: <loom.20150922T104305-736@post.gmane.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278385>

On Tue, 22 Sep 2015, Przemys=C5=82aw Skrzyniarz wrote:

> Hi,
>=20
> On page =3D>
> https://git-scm.com/book/pl/v1/Rozproszony-Git-Rozproszone-przep%C5%8=
2ywy-pracy
> < I found typographical error in first line (Is: powala =3D> Should b=
e:
> pozwala) in third part of text entitle "Przep=C5=82yw pracy z osob=C4=
=85 integruj=C4=85c=C4=85
> zmiany".
> And next line, it means third line at the bottom - of text entitle "P=
rzep=C5=82yw
> pracy z osob=C4=85 integruj=C4=85c=C4=85 zmiany" - is better to use "=
z" instead "do" (place
> in line - cit.: "... uprawnienia do odczytu do repozytorium innych os=
=C3=B3b w
> zespole ...")

The issues you found should better be reported to the progit community
on GitHub: https://github.com/progit/progit

Besides, the progit book 2nd version has already been released.  Please
check https://progit.org/translations to see how to start translation i=
n new
languages.

Cheers,
Ray
