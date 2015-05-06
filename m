From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 0/6] Make pull a builtin
Date: Wed, 6 May 2015 12:27:15 +0800
Message-ID: <CACRoPnR0+Ovnnz=HzRA7ZsHHUQ54JrPfih5E8wsRaKY-ajf-gA@mail.gmail.com>
References: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
	<1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Stephen Robin <stephen.robin@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 06:27:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypqvf-00051U-AJ
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 06:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759202AbbEFE1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 00:27:19 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:35157 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759193AbbEFE1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 00:27:16 -0400
Received: by labbd9 with SMTP id bd9so142802400lab.2
        for <git@vger.kernel.org>; Tue, 05 May 2015 21:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SsXadfUu1w3r12vYCCNPptYzmmJajBwIfukBNwgf1w0=;
        b=MkARvEOc5NUMWLabYwZ+F1FF9KGg7qlmrdFEoTuAM6TvvFTRAJik5q+c8RxPOlBwsQ
         WbrbYJlHdb1hIVpB/KwHA5eVU0L11gUXiy5GFoNcfKI8SIsHcPkh0auVJ6Jp8aB2dq34
         rXbrvH29kpzXVXmNXOYQiAd4FTpwdPm41oVRMdrEiDkkqjeezos7GWWQ4qP7XvM4iNoF
         a6tUAXubdI6vmLuolmIZXzdYZSlFmoXLJXmR/5MZmP/wt2UVNTyW+UKLj4LWML8OV/7l
         EMdg+oQJh4Vatb1VyXXduqcpcMyVEL8CSlIqOabO7oYqOjGcJCAiGDiRm6eAme62I3xy
         +Fmw==
X-Received: by 10.152.4.72 with SMTP id i8mr27637507lai.32.1430886435277; Tue,
 05 May 2015 21:27:15 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 5 May 2015 21:27:15 -0700 (PDT)
In-Reply-To: <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268444>

Hi Stephen,

On Wed, May 6, 2015 at 8:00 AM, Stephen Robin <stephen.robin@gmail.com> wrote:
> Hi Paul,
>
> Congratulations on getting your project accepted for GSOC. Here's my
> attempt at implementing pull as a builtin, maybe it will be of some use
> as you look to progress your version.
>
> It's fairly complete in the sense that all the features of git-pull.sh
> should be implemented, the test suite passes, and I've been using it
> myself without issue. At the same time it's some way from finished as
> I've never had time to test it fully and there are parts of the code I'm
> not happy with.
>
> Apologies for not sharing this with you earlier.  I have been too busy
> with paid work to look at any open source projects for some months.
>
> Good luck with your project!
>
> Regards
> Stephen

Thank you so much for sharing your work. I'll be referencing this.

Regards,
Paul
