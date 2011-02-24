From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: how a patch can be accepted?
Date: Thu, 24 Feb 2011 01:04:57 +0100
Message-ID: <AANLkTinQwbTva+LxKo_4Sz=bN-iZ8Qu8MP-zWianz-iQ@mail.gmail.com>
References: <AANLkTikPtYy9_4WjvSqdiFG8pjv5KH5e16=4HoeAzoWb@mail.gmail.com>
 <AANLkTin1hNwKfgRrukKvEMDXCSHnU=EfPFJLQ2cYci9L@mail.gmail.com> <4D63C095.8020206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: xiaozhu <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsOiH-0007YT-WF
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab1BXAFl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 19:05:41 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:34381 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab1BXAFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 19:05:41 -0500
Received: by yib19 with SMTP id 19so4106yib.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 16:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=dIGCO+ZP0W+cfQLo0oVDbh5aXdF5oEGPEI+ey4VN+kU=;
        b=YAHVjUvIqRgb9TQt+zwIjj/CDhl/+42FPRcvwTjblzL2NvSjU/Sprh+SodXndoIpRD
         s77cbR2sX5vC+mK59yIOF5SxKtcOArIw9OxnaQalubWeYl9hNKASbgd8Rff09dJ7U/PE
         QPD3m1ygzyOOhzonCMsij7FJLawALSCTCwFZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XA5A/YoXUEJco32YkxdiroDugYFuCc0ab5QZ2Sg2/ov3yEylzeNP3rQlvQlxVUzkos
         Nb6TzchGanU5EroIoT3pCGVZglbtkkIb+VrTA8gFRqZUrLZeRStM0QPUvmetV8QAExjd
         2JiBp9na16ML65zf4XG0kOwrEq4oNOnxWM+Dk=
Received: by 10.150.100.11 with SMTP id x11mr775637ybb.419.1298505937132; Wed,
 23 Feb 2011 16:05:37 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Wed, 23 Feb 2011 16:04:57 -0800 (PST)
In-Reply-To: <4D63C095.8020206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167751>

Heya,

On Tue, Feb 22, 2011 at 14:56, xiaozhu <xiaozhu@gmail.com> wrote:
> On 2011/02/22 1:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Did you read Documentation/SubmittingPatches?
>
> Where is the Documentation/SubmittingPatches? I didn't see anything
> about submitting a patch on the site of git, and I also tried to find
> something about it on git wiki, but I got nothing.

I've added a link on the wiki [0] to the kernel.org 'cat blob' view.

[0] https://git.wiki.kernel.org/index.php/Main_Page#Starting_points

--=20
Cheers,

Sverre Rabbelier
