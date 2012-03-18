From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [L10N] New po/git.pot generated for Git 1.7.10-rc1
Date: Sun, 18 Mar 2012 10:20:05 +0800
Message-ID: <CANYiYbGtnHbOGYhVc_gCa71PiTM=q8YMz6OH0-kQrw6R-ah_yg@mail.gmail.com>
References: <CANYiYbGZ7mQaqyAxOiHOdMfDSy0VsDgLaWiBTTaZ30asiSU0nQ@mail.gmail.com>
	<4F64C837.10700@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sun Mar 18 03:20:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S95jC-00027f-MQ
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 03:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109Ab2CRCUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 22:20:07 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63582 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757073Ab2CRCUG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 22:20:06 -0400
Received: by vbbff1 with SMTP id ff1so347035vbb.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 19:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ylv/Ok0EmTonMbHtrxl20WazwuiJ4+gfra3oM4Q+8K8=;
        b=iI2AJHxHxqY03TvpfmHIJOmXpwI6XGwkZ0ApvLReiHPvUMmleCdFPuejn29n6x62oq
         IKHVPy8cX+oGohXFnti7WesyChzxAG7I+LqXDbGdi6YwNP96sIuYpEV+Eg5qhBGx20TX
         NcgXEzVocWOuLTwONyIzERDW+hO8IT7y9qWKUaFlsE9O9OVYL4BH82Y0HQpyfJMK0Fz0
         qGzvhTvPn5cMfi7M7vU6UQh8/Oh/esSljCw7HILiM7PNfVevnGSQQ6Ulo13DBKm/IOTC
         H225NI9ivBrVMzhk0jmnkC82XR8fTdz73KArOKQdChnuikyyIIdH+gsyhDDDMPoC+XT5
         Jp7g==
Received: by 10.220.229.66 with SMTP id jh2mr2619554vcb.40.1332037205145; Sat,
 17 Mar 2012 19:20:05 -0700 (PDT)
Received: by 10.52.26.37 with HTTP; Sat, 17 Mar 2012 19:20:05 -0700 (PDT)
In-Reply-To: <4F64C837.10700@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193365>

2012/3/18 Zbigniew J=EAdrzejewski-Szmek <zbyszek@in.waw.pl>:
>> =A0 =A0 =A0https://github.com/git-l10n/git-po/
>
> Hi,
> the slash at the end makes this an invalid url to pull from:
>
> % git remote add l10n https://github.com/git-l10n/git-po/
> % git fetch l10n
> error: RPC failed; result=3D22, HTTP code =3D 502
> fatal: The remote end hung up unexpectedly
>
> (Works fine with "https://github.com/git-l10n/git-po").

Next time I should write the url of the repo, not url of the project.

   git://github.com/git-l10n/git-po.git
   https://github.com/git-l10n/git-po.git

Thanks.

--=20
Jiang Xin
