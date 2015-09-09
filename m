From: =?UTF-8?B?Um9iZXJ0IE1hY2jDocSNZWs=?= <lighthunt.net@gmail.com>
Subject: Re: Bug report: GIT PRO/Branches chapter
Date: Wed, 9 Sep 2015 15:16:38 +0700
Message-ID: <CACwN7xFU4yFeh=RPmPk4kwKBL5WjTB7pBY8RFFFNgf+k-a_Q4w@mail.gmail.com>
References: <CACwN7xFG0RrCZCZiUb=h-x2svV3B6Q1U5b3=3x6r08ZZM3mPmg@mail.gmail.com>
 <9039e46ed0bc66aec7b30c24183acdb0@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 09 10:17:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZaZ9-0001J5-ET
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 10:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbbIIIRL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 04:17:11 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36417 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbIIIRI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 04:17:08 -0400
Received: by ykcf206 with SMTP id f206so3571107ykc.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3p0qB+1KLun0cIPtjTjJJbGOsyZSy3aR0lEuE4yFhag=;
        b=l5sjq8xBQMyKAhNkVcLgEfsBMaHLfU5tDV3XYdoQywWhDPrY6u1vERZjoi9E8elKBb
         9Av0SCbkekayCHaZUo2Vu57ydB1npVRMpmfiphg9OwQ+E7VhYbXZj2T8dmK5iMdKeNVe
         3HyLWaz9IH3uJ6TG+s3JhaJWlxQcZ+AJNgnGBqeFqq9KjXHljlwncffKLPV8U0ZcaWHv
         1Umjs/uFT07xoIOU2+rofyTgWZ5UaKu7PmSadcwex6Mo3dZK5Z4Hw1UP6rYS6hWr+ikx
         QK16utyVWzD3XW0wt08iU8xUlYgESuIaI5s/TbEr0Ptwy3kGFPDHw1o4nSKm05WVFAKH
         keUw==
X-Received: by 10.129.27.15 with SMTP id b15mr25458565ywb.162.1441786628073;
 Wed, 09 Sep 2015 01:17:08 -0700 (PDT)
Received: by 10.31.147.15 with HTTP; Wed, 9 Sep 2015 01:16:38 -0700 (PDT)
In-Reply-To: <9039e46ed0bc66aec7b30c24183acdb0@dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277535>

Hi Johannes,

Sorry, I am new to git, I have just followed instructions at
https://git-scm.com/community which says:

Mailing List
Questions or comments for the Git community can be sent to the mailing
list by using the email address git@vger.kernel.org. Bug reports
should be sent to this mailing list.

The last sentence is made with BOLD font and I assumed that this
applies to the book as well as it is hosted on this domain (so what
other bugs are they talking about BTW?)

I'll have a look to github*/issues as you've suggested.

Thanks,
Robert


On Wed, Sep 9, 2015 at 3:08 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Robert,
>
> On 2015-09-09 08:11, Robert Mach=C3=A1=C4=8Dek wrote:
>
>> Just reading this chapter:
>> https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell
>>
>> I believe that: Figure 3-9. Divergent history
>> (https://git-scm.com/book/en/v2/book/03-git-branching/images/advance=
-master.png)
>> does not show the final "2 branch situation" as described in the
>> example in this chapter.
>
> I guess you want to report it here:
>
>     https://github.com/progit/progit2/issues
>
> (as suggested by the link on the left side of the page you referred t=
o, where it says: "The source of this book is hosted on GitHub. Patches=
, suggestions and comments are welcome.")
>
> You might want to search the tickets first, though, to make sure that=
 it has not been reported before (or even already addressed).
>
> Ciao,
> Johannes
