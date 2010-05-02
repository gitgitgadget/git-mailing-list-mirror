From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Latest git-remote-cvs?
Date: Sun, 2 May 2010 15:34:39 +0200
Message-ID: <i2sfabb9a1e1005020634x5d600f95n585f4e4d8a0cfdba@mail.gmail.com>
References: <20100502101726.GA2514@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	David Aguilar <davvid@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 15:35:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8ZKC-0007hr-TD
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 15:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab0EBNfF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 09:35:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52667 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705Ab0EBNfA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 09:35:00 -0400
Received: by fxm10 with SMTP id 10so1415087fxm.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tc/RXcf8X55K8nnKp3RejfhHOIfgCeWWALPpEd35xEM=;
        b=q+aT+sjV/HZUyg7uLdBmRq9eKt3A75IFxQUEwD/E5N1KNBz/jDyZpNJpQk4ckbv5bx
         0a8yFk/10z6IROSGphElwqIbq5/FINuXSrnfTCob1yEmXGeNKGeK89LDJmYCSAiwBv5z
         MASsX8z6nudCiVoP2x/ZbeQTrUhJkuksjk98o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FbC7m1h5C/NFebrhhKaKBAGZ34ITHxAYVnnylMrmBuqh1G795vzCPLAYydk/mAhHzk
         ySe1GGUeFQlKAIe74bTgaYv1nDybVTATPPoSn1eIgS+5xngDBrGRW82L9gb2QrZKH8R0
         aCQ3JbBdTQAK6LClKDWAacY24B2n2rtrCfGLc=
Received: by 10.102.14.5 with SMTP id 5mr7889609mun.33.1272807299079; Sun, 02 
	May 2010 06:34:59 -0700 (PDT)
Received: by 10.103.107.13 with HTTP; Sun, 2 May 2010 06:34:39 -0700 (PDT)
In-Reply-To: <20100502101726.GA2514@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146174>

Heya,

On Sun, May 2, 2010 at 12:17, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Occasionally I find a few minutes to dabble with remote-cvs, but now =
my
> branch is starting to bitrot. =C2=A0The latest iteration of the patch=
es I
> can find is that posted by Sverre on 29 October[1]; has there been an=
y
> progress since then? =C2=A0I am wondering in case time suddenly frees=
 up to
> start rebasing.

Nope, I haven't rebased it since you said to take it out. If you need
help with rebasing it to match the latest protocol etc., feel free to
ping me :).

--=20
Cheers,

Sverre Rabbelier
