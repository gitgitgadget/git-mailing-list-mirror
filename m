From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 00/16] make usage text consistent in git commands
Date: Sat, 23 Feb 2013 16:37:21 -0800
Message-ID: <CAJDDKr5UC3UP6kS_iq16CJ-TNRVQmDOthAbo4kb3-B2=acM+Nw@mail.gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
	<20130224002939.GH3222@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PbA-0005Ic-BB
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759205Ab3BXAhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:37:23 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:43390 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758968Ab3BXAhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:37:23 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so739588eaa.39
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=+BD0/uBHHDljGFHDLu7OPuOey1MBRnlcM7UEMR5Ug5g=;
        b=rUl9VXLar2leX5k/YoKToU0PWHuz44Y89sSQPPwaabYDOxDzrfXJQFH5ikjilrKt4U
         IYJlT7dY1z+2m9LUF3xj+3nCLN53E5ZxubO/XX/cnr9jMGzRQRawiUySbaDkJSxBxjJN
         BI55yuRY9gZbx29udMpEkSn8wvW9o5CeQfgktTSbmIgyx38oIy/kYJu8TpezPE8flnkD
         MAvo9fWL2wFR8YWqMRVS5Fks+wHhPIcchrVEbGAD93bxP2KnPD4gk9WAkO63qwTBX7Ri
         sheXgId83gA+ENRuvftsWaVItqKKYlfWyM4zpUD0W+OA061+Iwg7DXnT7WS685J2TrP4
         d77A==
X-Received: by 10.14.207.200 with SMTP id n48mr22867901eeo.4.1361666241987;
 Sat, 23 Feb 2013 16:37:21 -0800 (PST)
Received: by 10.14.194.3 with HTTP; Sat, 23 Feb 2013 16:37:21 -0800 (PST)
In-Reply-To: <20130224002939.GH3222@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216957>

On Sat, Feb 23, 2013 at 4:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> David Aguilar wrote:
>
>>   git-sh-setup: make usage text consistent
>>   git-svn: make usage text consistent
>>   git-relink: make usage text consistent
> [...]
>
> Micronit: titles like
>
>         git-relink: use a lowercase "usage:" string
>
> would make the effect of these patches easier to see in the
> shortlog.
>
> With or without that change, all of these except patches 11 and 12 are
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> I have no opinion about patches 11 and 12. :)

Thanks for the review.  I will post a re-roll later to fix these.
-- 
David
