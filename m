From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: Git roadmap (How read What's cooking in git.git)
Date: Thu, 18 Nov 2010 02:55:30 +0100
Message-ID: <AANLkTikDyxUWBnCzxRNA9MzBmr0LrqDb1ggNjOTc=7DR@mail.gmail.com>
References: <AANLkTimtUz3L0F_iOpH7YuYpyoutPqtevPj-Tjo6MRcs@mail.gmail.com> <AANLkTim4FOixgxUjv24o9gTNqK3DWafmpNtDVMA+PS9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 02:58:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PItlV-0005aO-IY
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 02:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab0KRB5w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 20:57:52 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40226 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab0KRB4N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 20:56:13 -0500
Received: by iwn35 with SMTP id 35so2847843iwn.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 17:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kWub8W8s6Av1ygHtxmtzfnsNw2QzeIwoC2xn2od8JKs=;
        b=nZmtM5jUQwvx+UfhXkjsgRfJBAI7Js2HEczBXXa8SBIbmhQxODyFVlf5EcIbJ3zUfR
         jXTA42SzS1rIrqwrcEEMA/KyCKZv/3HO+e+ic3O6dkXfcbTepignTaom99RuDTBf7wKy
         tSN71Pqc5RINCBwq3gfvS7cGyw45V56FhkLSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hkebWuDb3NddyNJVyR9zKEVNhzEQSg6HKJOzozMbnLU25QQ7bD/erO628xVUhscDxB
         e/dnE1vx23rrpbRBO99+W2mQWGenMGxIj4s3ptwpnLKcqSvDsmekjvzrHU0PL8u8lmCm
         V8x+OgYxgqCmr3tPtZCn3BRi8J3upBvKxkc3Q=
Received: by 10.231.17.9 with SMTP id q9mr7433931iba.109.1290045370246; Wed,
 17 Nov 2010 17:56:10 -0800 (PST)
Received: by 10.231.174.20 with HTTP; Wed, 17 Nov 2010 17:55:30 -0800 (PST)
In-Reply-To: <AANLkTim4FOixgxUjv24o9gTNqK3DWafmpNtDVMA+PS9d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161645>

On Tue, Nov 16, 2010 at 14:38, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

Hi  =C3=86var,
thank you for your response.

> Projects that have a "Roadmap" are usually the ones that have paid
> developers, where someone will centrally plan what things get worked
> on. Then assign developers to those tasks.

It's a bit surprising that you (the core devs) haven't any ideas on
the future versions. But roadmap is maybe a misleading word, I talk to
leverage a bit the visibility of the project for users. It's not a
major point, "what's cooking" is a nice overview (understand it is a
different kettle of fish).

> What we'll end up implementing is a function of what patches people
> send, and which of those patches end up passing review and get into
> git.git.

Cool.

> You can get something like a roadmap just by following what people ar=
e
> working on, and asking them what they want to do next.

Understood. I will make it.


BTW, congrats. Git is a wonderful piece of software.




--=20
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche (agile, lean, python, git, open source)
