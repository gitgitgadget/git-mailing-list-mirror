From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Problems with Git's "perl" userdiff driver
Date: Sun, 15 May 2011 22:13:02 +0200
Message-ID: <BANLkTik_Y0uXeO5kd7jxK=4Q47uickEVoQ@mail.gmail.com>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
	<7vk4drpwal.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 22:13:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhgc-0002oM-Iy
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab1EOUNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 16:13:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45111 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab1EOUND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 16:13:03 -0400
Received: by fxm17 with SMTP id 17so2656829fxm.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9JviZ3CndWoAyVQ2lGECrKJ9zi2yldr6Jn6NI0gl1Og=;
        b=aCaCWd0VsQVHBWX9T0NrY3MYShbaYx5cVcW7Bi14CsBEkquPaKznE/LtJprXZ+MH/Z
         4VmaXpQrnOzEhyp+/iS7pBai21B0P2LX+qaXT+VL4Ciudj09nouGwcLt5Zi1DNr1LEy7
         bOftkbI3FFqUVxfcNtCJEz+owQv0DUm7mSWLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PUj8+r18MvZdkyVTJJ/HJU9i5msVfQpRZXnRYfosoNM0gHqIySIIppbEVLIFh5QWA1
         hvstWDxRQ1h/wHRZjt1HII5iwUmA7NToy5IZ3J/meM7q+7aJRGWb6SOynvW6Q7+7Ei5G
         LaKv+2siwlZzYUCIvGXHsl7wHUfghcK9T06S0=
Received: by 10.223.145.78 with SMTP id c14mr3903838fav.75.1305490382451; Sun,
 15 May 2011 13:13:02 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 15 May 2011 13:13:02 -0700 (PDT)
In-Reply-To: <7vk4drpwal.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173657>

On Sun, May 15, 2011 at 22:02, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Dec 29, 2010 at 06:22, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> Heh; without in-reply-to or references, this is useless, isn't it?

As far as I could tell the patch you appended to that series was never
submitted to the list, so I couldn't reply to it. Thanks for providing
the sha1's.
