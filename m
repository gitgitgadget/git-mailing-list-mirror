From: Scott Chacon <schacon@gmail.com>
Subject: Re: Talk about Git (slides etc.) for intermediate + advanced audience
 that I can steal?
Date: Mon, 23 May 2011 12:06:54 -0700
Message-ID: <BANLkTinzj_UAROyJo-hpDF0GR4m5e0Q1-g@mail.gmail.com>
References: <BANLkTi=uF0qXKGAJhF+OPEqx2P1=YJRSXQ@mail.gmail.com>
	<BANLkTinX5KN+9ot1DGxxOqmCgAO4+4kr-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 21:07:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOaT1-0006qw-1T
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 21:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab1EWTGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 15:06:55 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58788 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab1EWTGy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 15:06:54 -0400
Received: by yxs7 with SMTP id 7so2248558yxs.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2P2iErfmYiOw0adlVedNM2dd8Vbw6Kk3pDeJAPtrbj8=;
        b=rg0xeqByB0v2ziHN/RDA7ewSrHAJ6a/ynqDxltozQDZU+YtmCItwq0eAg2pFtftFOt
         k8VcCjkLd3krok4ihSj0oV8wHtzNFR5VaAGks0XFBCGmVjO+p7Lhb3HEWgRfmqqAhcKv
         k9bHPz1hS6KyNKRahfz/SFwwhoEAbYBZhu9Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jrbeYqwXX4rUehkHKfviS+Auk/1zORXaR15W7d6VeMnD/rACUaB8l355eapCZ/SVPF
         KZMH6fVcwH4ZDAF5z0vzxF37GAde8r8xLY4zaKv7jEv2e+HuGZHBwWJI8j+zzgcmoYGE
         vBwml7E82frzTsIsGNL6kWrY+ASdrMoAaUIrA=
Received: by 10.236.125.234 with SMTP id z70mr3272047yhh.357.1306177614209;
 Mon, 23 May 2011 12:06:54 -0700 (PDT)
Received: by 10.236.61.74 with HTTP; Mon, 23 May 2011 12:06:54 -0700 (PDT)
In-Reply-To: <BANLkTinX5KN+9ot1DGxxOqmCgAO4+4kr-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174261>

Hey,

On Mon, May 23, 2011 at 12:58 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
<avarab@gmail.com> wrote:
>> Does anyone have slides for something like this already that I could
>> look at and steal ideas from? If not I can just write my own.

I've done Wrangling Git a few times - here are a bunch of slides
online and PDF download:

http://speakerdeck.com/u/schacon/p/wrangling-git

I do my presentations in ShowOff (an HTML/Markdown based system), so
you can get the source for the slides here:

https://github.com/schacon/showoff-wrangling-git

Hope that's helpful,
Scott
