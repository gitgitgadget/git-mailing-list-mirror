From: Adri Farr <14farresa@gmail.com>
Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools
Date: Sat, 15 Nov 2014 15:22:31 +0100
Message-ID: <CAPfWmhiPgka9ok30eXswcy1jb+g4pcNV80QM-YVvn5r-KebAUQ@mail.gmail.com>
References: <20141115002710.GA72216@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 15:22:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpeFI-0003YS-Qq
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 15:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbaKOOWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 09:22:34 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:41190 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbaKOOWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 09:22:33 -0500
Received: by mail-lb0-f170.google.com with SMTP id w7so5483078lbi.29
        for <git@vger.kernel.org>; Sat, 15 Nov 2014 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UOPl2M5uRMotHi3AzTBJBHqyxMXNBZdNm+I1CnhNSU4=;
        b=uqMSp5wnbnzXlJ3eVqDtunVUWIgZ13kBuvmC1qojUKHelCO/4iT5J8W9BEsDqqYNsE
         iZQi3ZTYUsHTqO+CqJ2IlEgUeuMlclF5oOKLLPSzQXGYBIPzxfGxSylmuyUlmDffz9rz
         mzvWCP1m5gSpjlGS+bTSO2W/I88Gq3mozKtHXfbZDoofFXJ8uWQWgn8Muy53nzmSMbgw
         Tg75fCw4WFCeHOL4QRPflJVfJ9Q9lYtC0JTxW3VggbqwpHoos8m3b+Z3WobURLMbw+++
         2dcstCD5WgiiHHFs9EBtn9QKT0XyEsaWgBTA1YP5FyHwtSsIVrj0Xr6D6xBqUmBJnnMC
         0Jew==
X-Received: by 10.112.63.133 with SMTP id g5mr14031636lbs.33.1416061351749;
 Sat, 15 Nov 2014 06:22:31 -0800 (PST)
Received: by 10.114.181.40 with HTTP; Sat, 15 Nov 2014 06:22:31 -0800 (PST)
In-Reply-To: <20141115002710.GA72216@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, sorry about that. I didn't realize I was directly responding to
you. Apologizes. Hopefully I'm doing it right this time. I don't have
much experience with mailing lists, and Gmail doesn't seem to help.
You don't need to add the 'Tested-by' line. Testing is the least I can
do. If you still want to add that line, my full name is 'Adria
Farres'. Thank you!

2014-11-15 1:27 GMT+01:00 David Aguilar <davvid@gmail.com>:
>
> Adri sent me this directly but I think it should have gone to the list.
>
> Adri, if you don't mind, Junio can add:
>
> Tested-by: Adri Farr <14farresa@gmail.com>
>
> ...to the commit message trailer since it looks like it's happy.
>
> Thanks for testing!
>
> cheers,
> David
>
> ----- Forwarded message from Adri Farr <14farresa@gmail.com> -----
>
> Date: Sat, 15 Nov 2014 00:10:12 +0100
> From: Adri Farr <14farresa@gmail.com>
> To: David Aguilar <davvid@gmail.com>
> Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools
>
> I have tested this patch both in vim and meld and it works
> wonderfully. Thank you for the time put into this. I should have
> provided feedback back when the patch was proposed. I guess it's never
> too late :).
>
> 2014-11-14 22:57 GMT+01:00 David Aguilar <davvid@gmail.com>:
>> [snip]
>
> ----- End forwarded message -----
