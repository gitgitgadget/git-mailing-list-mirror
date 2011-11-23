From: David Aguilar <davvid@gmail.com>
Subject: Re: Feature requset: listing of current stash in git gui
Date: Wed, 23 Nov 2011 03:20:24 -0800
Message-ID: <CAJDDKr78CV+eDrfSg4Tqp5W2N4MDTaqAcxiB5JrNpUyEn5vqAQ@mail.gmail.com>
References: <201111211100.52367.dexen.devries@gmail.com>
	<4ECA2D8F.4060005@atlas-elektronik.com>
	<30417194.1411.1321907485839.JavaMail.mobile-sync@ieja14>
	<-8099236111493298698@unknownmsgid>
	<4ECBBD72.40101@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dexen deVries <dexen.devries@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 12:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTAsQ-0003lr-Vq
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 12:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab1KWLU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 06:20:27 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47625 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab1KWLU0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 06:20:26 -0500
Received: by ywt32 with SMTP id 32so1233046ywt.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xkU1up1N9HZvXXuP7XWwX3tU82dq2RR9d7/5d8fdFbE=;
        b=n3gFI38h3M+Wxx+keeUVNpR298hXVWpsj73UzATuY8ac43gYDWKS5Z+d+urNjtSVcN
         njYRhEYXtetWib/0QXW1VyHUv08kWD/hEALJJZFnTWIrifgeNq/ZM7ArUx1wTgp5Hkvb
         m1Tcrnn453ftXm0hxIQURzawpuJtC2bRzBLNQ=
Received: by 10.236.77.233 with SMTP id d69mr32987695yhe.84.1322047224220;
 Wed, 23 Nov 2011 03:20:24 -0800 (PST)
Received: by 10.150.190.2 with HTTP; Wed, 23 Nov 2011 03:20:24 -0800 (PST)
In-Reply-To: <4ECBBD72.40101@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185837>

On Tue, Nov 22, 2011 at 7:19 AM, Stefan N=C3=A4we
<stefan.naewe@atlas-elektronik.com> wrote:
> Am 22.11.2011 11:24, schrieb David Aguilar:
>>
>> git-cola has this feature.
>>>
>>
>> =C2=A0 =C2=A0http://git-cola.github.com/
>
> Yeah, right. I totally forgot about git cola.
>
> But I guess there's no way of starting only the stash view like the '=
DAG'
> view, is there ?

That's a good idea.

https://github.com/git-cola/git-cola/commit/0b1bf59c0b4a455cc8a9149dcfc=
afb5bed3a19ab

    git cola stash
    git cola classic
    (and a few others)
    ...
--=20
=C2=A0 =C2=A0 David
