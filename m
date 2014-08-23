From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 38 new messages
Date: Sat, 23 Aug 2014 19:25:18 +0200
Message-ID: <CAN0XMOKU10PvK_-pqX_+8Xk6UX5WcMbzk+CaJgkPx-XBuZGeeA@mail.gmail.com>
References: <1407261111-24839-1-git-send-email-ralf.thielow@gmail.com>
	<CANYiYbErvzbW_gMseJyQ8=AY8Z36TRkG2NorwxeARHi0oSsoCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 19:25:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLF4E-0002ld-2D
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 19:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbaHWRZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 13:25:22 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:35668 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbaHWRZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 13:25:19 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so11713520wes.14
        for <git@vger.kernel.org>; Sat, 23 Aug 2014 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=csnL1fatOz9XLeuN6zPKRSo9US3ltbbs9vWCNFtzlGc=;
        b=xIq25pzfELAQvtaRIAx2cOtXPmsiggdkYRv2QSZlzXtoRagcyVvgPlUbtTpqjSOFZh
         7hi1As2FjTggI84JQ76PjXErdi3MfWPNCXQ8IGaIF6BRnvqfa4AndxOqd0kKCwEffLUM
         buVzfntsXut92A9D7hyVmL3vcCsXxRiDEEKCvwftwBMEIttejZGAHpUFTNR/Es4qoCSV
         v6HJBqW1ShRK2cU6uQ8+tjvKN7ITd/KkJKI7QSe5PI+gCENJEOCNRICrHcsr6f+5v5qr
         2rBftp06Ws8K9lomtSHoq4+Hpdc21gOG6qmKEw/+J3rFuadB36G5mfIh5I3Ps31Y/Iyl
         SjJQ==
X-Received: by 10.180.210.172 with SMTP id mv12mr4995988wic.45.1408814718226;
 Sat, 23 Aug 2014 10:25:18 -0700 (PDT)
Received: by 10.194.178.227 with HTTP; Sat, 23 Aug 2014 10:25:18 -0700 (PDT)
In-Reply-To: <CANYiYbErvzbW_gMseJyQ8=AY8Z36TRkG2NorwxeARHi0oSsoCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255760>

Hi Jiang,

2014-08-23 14:29 GMT+02:00 Jiang Xin <worldhello.net@gmail.com>:
> Hi Ralf,
>
> If it is ready for merge, let me know.  We have already missed the
> v2.1.0 release (it's my fault), I don't want to miss the release of v2.1.1
> again.  Alex contributed l10n for a new language (Catalan), and
> I will send a new pull-request to Junio in a few days.
>

It's not ready yet, but I have two fixes in the queue that I wanted
to send you as part of the pull-request for v2.1.0. I'll send you a
pull-request with these fixes separately and will send a new pull
request once the translations for v2.1.0 are ready.


> 2014-08-06 1:51 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
>> Translate 38 new messages came from git.pot update in fe05e19
>> (l10n: git.pot: v2.1.0 round 1 (38 new, 9 removed)).
>>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>>  po/de.po | 131 ++++++++++++++++++++++++++++++---------------------------------
>>  1 file changed, 62 insertions(+), 69 deletions(-)
>
> --
> Jiang Xin
