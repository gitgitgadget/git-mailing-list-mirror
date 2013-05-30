From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7] Add new git-related helper to contrib
Date: Thu, 30 May 2013 07:12:13 -0500
Message-ID: <CAMP44s0ystM--SJgY-zgM+KKC9NKfHK_jF-w+nUN2tZ1dXmzJw@mail.gmail.com>
References: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=ZbOy6sXOvnTNAqz_UBsUymY1CR_WczT-O3Q+18HJjzQ@mail.gmail.com>
	<CAMP44s25vX1p1Np7yqc9_AqVBme+MCTY88hjhfWdL6KZkxgs7Q@mail.gmail.com>
	<CALkWK0=LfhDtOAgsq2KYSCbTocf2R8FjTWg4S6jxGiGxDxeg1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 14:12:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1iO-0001BR-2S
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab3E3MMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:12:16 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34942 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab3E3MMP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:12:15 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so157861lab.25
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gkgeWv/My4WNdRjPnMLQtm4sRR5zBQCHS/QnvcqqzpQ=;
        b=HYTr40CkYzIrsb3WijhrKhKVk+SoGujQK9qmJNay/91toenPTZgpDm6lSKG2HcUXF7
         FXmtwidVp3byA1wMFV29rIcZCuq6On/yjauEgdiMPJps828b10q6hxqJACgN+1pfPtFL
         P15f4ZVKovgR6PnVgrLLRZtQ37IyzHqHwGGgFhLq7SYdr2qUoCgFRWoAZSaeEMQcRuhk
         81dknwOgwCjAn42HdPzDW7aAlaPoTeUDMnXoxD9j9wB1HcIUicB9XAMeZdN4BBoR8KdR
         wGagfCeawVUct8343qgGEcHqCIlGR56nuOeYT978Dj8hzXJyLUAX/egDDiL5PoVqvOS2
         Evrg==
X-Received: by 10.112.236.70 with SMTP id us6mr3484092lbc.121.1369915933818;
 Thu, 30 May 2013 05:12:13 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Thu, 30 May 2013 05:12:13 -0700 (PDT)
In-Reply-To: <CALkWK0=LfhDtOAgsq2KYSCbTocf2R8FjTWg4S6jxGiGxDxeg1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225975>

On Thu, May 30, 2013 at 7:08 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> What's your objective? Block this patch from ever going in?
>>
>> Not a single one of these comments makes a difference at all, all of
>> them can wait until after the patch is merged, many of them are a
>> matter of preferences, and some of them have already been addressed as
>> precisely that: disagreements in style.
>
> You posted a patch, and I reviewed it.  End of story.  I never
> explicitly or implicitly indicated that I want to block the patch, so
> stop pulling stuff out of your arse.

That's exactly what you are doing.

Do you see any other reason for not merging this if not your comments?

-- 
Felipe Contreras
