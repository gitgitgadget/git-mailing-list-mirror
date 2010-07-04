From: Scott Chacon <schacon@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Sun, 4 Jul 2010 15:43:49 -0700
Message-ID: <AANLkTik1JCMTSlzeKfkAChkrJGq_KeAOqy7iGkMtKsR8@mail.gmail.com>
References: <201007032158.57700.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 00:44:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVXut-0003A3-Pp
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 00:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab0GDWnw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jul 2010 18:43:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39573 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab0GDWnv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jul 2010 18:43:51 -0400
Received: by ewy23 with SMTP id 23so1500633ewy.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 15:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=js2tk71RfoNlap+VXbrwmMsbMS/2ZLO1nmPs51Ba6SE=;
        b=Iyujo6e6vdz0zyf52tu+YmxK+zMzU5kqNB9Qk4+lyeBPlsJSGVsDGOuhgTtimlbp0+
         xvzj8b5pVyC0asFMmt25FyR2ddhH0YTg3MhXUhle3r1jn68whQGWGNFnaDmjwiaIShYq
         1aEjoL6VUhmOKS9kiwmHcY5ZKhuYCYmNNfSTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hiBqEeBDX+NAKxrIk7PV5TVUE5QdjNKsRP7b5NBjybWxCvjN+hvRnx9/Zt5cWENtV4
         jKAkCNatSy10vWj0RB5WnWWl3sCmR2+gE8dKM8iFBYwzOtEcNRTMbBC+olIs7FvETOnz
         2cg/WgVQbDRl+u4207ocG/tGqDnbY7stB9zjo=
Received: by 10.213.25.143 with SMTP id z15mr1551695ebb.25.1278283429194; Sun, 
	04 Jul 2010 15:43:49 -0700 (PDT)
Received: by 10.14.127.72 with HTTP; Sun, 4 Jul 2010 15:43:49 -0700 (PDT)
In-Reply-To: <201007032158.57700.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150234>

Hey,

2010/7/3 Jakub Narebski <jnareb@gmail.com>:
> =3D=3D=3D 09. On which operating system(s) do you use Git? =3D=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ Linux (includes MeeGo and Moblin)
> =C2=A0+ MacOS X (Darwin)
> =C2=A0+ MS Windows/msysGit (MINGW)
> =C2=A0+ MS Windows/Cygwin
> =C2=A0+ FreeBSD, OpenBSD, NetBSD, etc.
> =C2=A0+ other Unix
>
> =C2=A0+ iPhone OS
> =C2=A0+ Android
> =C2=A0+ WebOS
>
> =C2=A0+ Other, please specify
>
> NOTES:
> ^^^^^^
> The iPhone OS, Androind and WebOS answers are new this year.
> OpenSolaris died, so I removed it. =C2=A0I wonder if it is worth it t=
o
> differentiate between MS Windows/msysGit and MS Windows/Cygwin, or if
> we should just have one, single 'MS Windows' choice.

Are any of these new options relevant?  I'm pretty sure there is no
working Git implementation in iOS, Android or WebOS.  Why were they
added?  There are some libraries for iOS, but I'm pretty involved in
almost all of them and as far as I know you can't really do anything
interesting with them yet.  And I'm pretty sure Android and certainly
WebOS don't have working implementations yet either.

Scott
