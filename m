From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 4 new messages
Date: Tue, 31 Jul 2012 10:45:41 +0200
Message-ID: <CAN0XMO+=8rd8qfLUaAyKe58RGb-iQdi3mKHX0wAgdsLfHWHg6Q@mail.gmail.com>
References: <1343664536-11408-1-git-send-email-ralf.thielow@gmail.com>
	<alpine.LNX.2.01.1207311009300.11095@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	worldhello.net@gmail.com, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Jan Engelhardt <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Tue Jul 31 10:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw85M-0003ve-OH
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 10:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab2GaIpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jul 2012 04:45:44 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57286 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833Ab2GaIpn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2012 04:45:43 -0400
Received: by wibhq12 with SMTP id hq12so3133482wib.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WtbaBHgxwTWIo7jaUl7I017mQ42Wqk0pBw7FHVnpVHE=;
        b=BbfOQ4tGngKJXf2PV21VOPwTfOkSuP/r1j/oKOPNRhFF7F1fQMxY9PcXj/xdz3nXmu
         pLzQGaEXVqrzNYRktiZ0POLC2/Y+krXGvYceGkb4h6DEMU7cV9NA0Ge3hVnqIjXdfY0d
         +EWBhhQPw+fGs6BjayVvmgESn5RnkFIvVGd0NoIwgFpJ7mJ/0aVE6qL7gaip6LBjTuIv
         C6WP9q5RNce0n6TTOtwuRLQ3js29UO0GRx/UpEOxwjb+H2tQHB/tEz8yuxEwDc8cwGqq
         mi7kbvUQqQNHgxoM0YCImtZPSJ4wWx8YgHDJgt2y0KvEpjtPXiluZSZ3VmvMex6svtOB
         IqZg==
Received: by 10.216.192.85 with SMTP id h63mr6949175wen.7.1343724341839; Tue,
 31 Jul 2012 01:45:41 -0700 (PDT)
Received: by 10.194.26.33 with HTTP; Tue, 31 Jul 2012 01:45:41 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.01.1207311009300.11095@frira.zrqbmnf.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202636>

On Tue, Jul 31, 2012 at 10:13 AM, Jan Engelhardt <jengelh@inai.de> wrot=
e:
>
> On Monday 2012-07-30 18:08, Ralf Thielow wrote:
>
>>Translate 4 new messages came from git.pot update in 0bbe5b4
>>(l10n: Update git.pot (4 new, 3 removed messages)).
>>
>>Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>>---
>>Hi German l10n team,
>>
>>please review this small update on German
>>translation.
>
> Patch is fine from a translation POV;
> but I wonder where my contributions had gone.
> =C3=86var, were they ever merged?
>
> commit 0c3db7e983a58f53cbd468e11937750e155de179
> Author: Jan Engelhardt <jengelh@medozas.de>
> Date:   Thu Oct 7 20:52:26 2010 +0200
>
>     po/de.po: complete German translation
>
>     Translate all 689 currently translatable messages in Git into
>     German. Making the German translation 100% complete.
>
>     [=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason: Modified by running msgm=
erge(1) on it to
>     normalize the line wrapping, and squashed two of Jan's commits
>     together]
>
>     Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
>     Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>
>

I didn't notice that you made a contribution to the German
translation. As described
in po/README, we have a dedicated repository on GitHub [1] which is a
fork of the
git-po repo. If you want to contribute you can fork this repo and send
a pull request,
or send a patch to the ML. Please read po/README for more informations.

[1] https://github.com/ralfth/git-po-de
