From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Mon, 5 Jul 2010 01:48:45 +0200
Message-ID: <201007050148.51549.jnareb@gmail.com>
References: <201007032158.57700.jnareb@gmail.com> <AANLkTik1JCMTSlzeKfkAChkrJGq_KeAOqy7iGkMtKsR8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 01:49:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVYw5-0000uk-TY
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 01:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab0GDXtE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jul 2010 19:49:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54075 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab0GDXtC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 19:49:02 -0400
Received: by bwz1 with SMTP id 1so2439877bwz.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 16:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jTcRznD03eEkHN618e+fPH22iGgVtFXWqEVa7/dBOkk=;
        b=G3ehmIMewGGbwDkDccVmA7w6d6gineAxu2xYTdCsxJowj0P9G07RdyUFcet9qq5Sd/
         abJU/FPUtuI4c3aO2XZWeovstXutNVskglrJVM3Ykr74DchyNmyjjteqpvfS++G11pKK
         dSWr/SJI+6vGw3ZaotgDCjXtNN/cYQ4UDYezc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=k2vUklaVNZ/azkEZsmCnOXqfSvdiH7FsG765H3Pnzc6AXL7trKADKiykbmGiR6xqmG
         ZIk0xv+yYOliDOLVai2wQIj46EmQQqZSSfb0kWAhiWV2JLOJnVAGo8AgW6kwmR4FEse+
         ly+WpR5Ry+YKzK6S3rcZI6ubI3CRwRk1Sid4A=
Received: by 10.204.175.1 with SMTP id v1mr294802bkz.140.1278287340372;
        Sun, 04 Jul 2010 16:49:00 -0700 (PDT)
Received: from [192.168.1.15] (abvt37.neoplus.adsl.tpnet.pl [83.8.217.37])
        by mx.google.com with ESMTPS id y27sm14912508bkw.14.2010.07.04.16.48.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jul 2010 16:48:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTik1JCMTSlzeKfkAChkrJGq_KeAOqy7iGkMtKsR8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150235>

On Mon, 5 Jul 2010, Scott Chacon wrote:
> 2010/7/3 Jakub Narebski <jnareb@gmail.com>:
> > =3D=3D=3D 09. On which operating system(s) do you use Git? =3D=3D=3D
> > (multiple choice, with other)
> >
> > =C2=A0+ Linux (includes MeeGo and Moblin)
> > =C2=A0+ MacOS X (Darwin)
> > =C2=A0+ MS Windows/msysGit (MINGW)
> > =C2=A0+ MS Windows/Cygwin
> > =C2=A0+ FreeBSD, OpenBSD, NetBSD, etc.
> > =C2=A0+ other Unix
> >
> > =C2=A0+ iPhone OS
> > =C2=A0+ Android
> > =C2=A0+ WebOS
> >
> > =C2=A0+ Other, please specify
> >
> > NOTES:
> > ^^^^^^
> > The iPhone OS, Androind and WebOS answers are new this year.
> > OpenSolaris died, so I removed it. =C2=A0I wonder if it is worth it=
 to
> > differentiate between MS Windows/msysGit and MS Windows/Cygwin, or =
if
> > we should just have one, single 'MS Windows' choice.
>=20
> Are any of these new options relevant?  I'm pretty sure there is no
> working Git implementation in iOS, Android or WebOS.  Why were they
> added?  There are some libraries for iOS, but I'm pretty involved in
> almost all of them and as far as I know you can't really do anything
> interesting with them yet.  And I'm pretty sure Android and certainly
> WebOS don't have working implementations yet either.

I have added those because (perhaps by mistake or misunderstanding)
there were a few such answers in 'other' operating system answer.

--=20
Jakub Narebski
Poland
