From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: Re: exporting a .git file ?
Date: Mon, 27 Aug 2012 15:48:12 +0100
Message-ID: <CANkmNDe10dtgtJ2sTJvS_75iY3v75_GCh219+dEOYGBurLaT2g@mail.gmail.com>
References: <CANkmNDc7VP4QiocxuB7JMuQyZy5nDT=ertow_ib2Hri_=XRMOA@mail.gmail.com>
 <CAPBPrnu1FNbWP+k6Nq5NudBFYZu9njjbcL+oL7m-z5sajuXpBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 16:48:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T60cK-0003a7-4M
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 16:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab2H0Ose (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 10:48:34 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52774 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab2H0Osd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 10:48:33 -0400
Received: by dady13 with SMTP id y13so2591445dad.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5VQuQnxcs8FfEOa1t9pNa3VBeLoVtXOjode1xFPEXCI=;
        b=uDmy39UmBkrWTO8lI2FxTphQc9ce4uwjjjZk2I3t/l0sm0tqgLjmQBD+EO9O9Rk1MO
         UBrymXoZMctcLPwVe0OUigtCd9V0+HsMq2rJQ41XsE/pabAmQ7Pz0kOk121t62O7q9oQ
         HgWBC6MEBtigt0r0kPt+RviD8J8KDvz8+8fi/AavgSaLpFyJ59IQyaWW++VnMRzdL+BV
         dbwSF7vD7oW5oiGb4y6Jwj1TrsfLaJ0YgfJw2JNevK3EvJgqaUDz2Hzgr1ys3LlnWr26
         B1kX271LLxKMZOdHr+9k6GGd6B69KGPh16yC9XjW0JMGwEzE7Eac/qsQXx6ZKtYIa4OE
         fDjw==
Received: by 10.68.129.38 with SMTP id nt6mr35432814pbb.76.1346078913259; Mon,
 27 Aug 2012 07:48:33 -0700 (PDT)
Received: by 10.66.85.233 with HTTP; Mon, 27 Aug 2012 07:48:12 -0700 (PDT)
In-Reply-To: <CAPBPrnu1FNbWP+k6Nq5NudBFYZu9njjbcL+oL7m-z5sajuXpBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204347>

On 27 August 2012 15:45, Dan Johnson <computerdruid@gmail.com> wrote:
> On Mon, Aug 27, 2012 at 10:32 AM, Aaron Gray <aaronngray.lists@gmail.com> wrote:
>> Hi,
>>
>> Is there anyway to get my git repository as a single file ?
>
> You're probably looking for the git bundle command (see git bundle
> --help), but it's possible you might just want to use tar.
>
> Hope that helps,

Great thanks Dan, comes in under 2 megs, thats great.

Aaron
