From: Andrew Garber <andrew@andrewgarber.com>
Subject: Re: [PATCH] git-p4: correct indenting and formatting
Date: Wed, 12 Jan 2011 01:13:42 -0800
Message-ID: <AANLkTimJOsRd4WcDSJZcehP3nn_rckL4hx4ngt48w9gD@mail.gmail.com>
References: <1294808703-1848-1-git-send-email-andrew@andrewgarber.com>
 <7vsjwy33zn.fsf@alter.siamese.dyndns.org> <7vlj2q3339.fsf@alter.siamese.dyndns.org>
 <7vhbde331h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 10:14:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcwmR-00052i-35
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 10:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092Ab1ALJOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jan 2011 04:14:06 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39493 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab1ALJOD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jan 2011 04:14:03 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so129287eye.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 01:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SwIcqxy2ILwfN5ws7WzpX3MJNWtXV3v0q/7Y93IFrPk=;
        b=orDDVd0rOC1s4qBAnovzf6idcLnmo1GuRLgF5zzIgbSNPV4V1kdkACNmVje8ePViru
         wLKMT3d/eyRQmk02prfF3sKxzmv9ZKl444aOnlG/xfIj4ppEE8s5KrQkXIecvu50MYen
         hiRliA47Jo6jJvPHkV04R6KYo98tYpjcyutJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=INHq1fa5Y3ZOBuTc42yNCf1fsBPF5wPjW7DaAS3wM3F+Gg+4fZ/Ddk9nRGtM+BWdvW
         EjICEo0l7hh++CzKrYeV3TjpKPiItsHz7w3tGDYtU0tbafE+2a11F1F0Ln5/ngISWhDA
         iKWSish1V2Q1aQqbrxBS2XKBv+nYKkifclRi8=
Received: by 10.213.104.143 with SMTP id p15mr854136ebo.68.1294823642402; Wed,
 12 Jan 2011 01:14:02 -0800 (PST)
Received: by 10.213.98.83 with HTTP; Wed, 12 Jan 2011 01:13:42 -0800 (PST)
In-Reply-To: <7vhbde331h.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: tGYCHRm596CVps1NAMjoaSbENMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165011>

Great! Thanks Junio. Sorry about forgetting to sign-off my patch.

On Wed, Jan 12, 2011 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Andrew Garber <andrew@andrewgarber.com> writes:
>>>
>>>> - replace tabs with appropriate number of spaces
>>>> - minor tweaks to code formatting
>>>> ---
>>>> =C2=A0contrib/fast-import/git-p4 | =C2=A0 71 +++++++++++++++++++++=
-----------------------
>>>> =C2=A01 files changed, 34 insertions(+), 37 deletions(-)
>>> ...
>> Will queue on a separate branch for you, expecting that you are doin=
g this
>> in preparation for a new feature or a bugfix to the script.
>
> Forgot to say obligatory "Please sign-off your patch". =C2=A0Please d=
o so.
>
