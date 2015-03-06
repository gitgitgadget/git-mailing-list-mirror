From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Fri, 6 Mar 2015 09:03:28 -0800
Message-ID: <CAPc5daVo5tDpx2ybt7eMXgrMfGCh+pu5HDc=EpM9XqGLyyih7Q@mail.gmail.com>
References: <20150224220923.GA23344@peff.net> <CAP8UFD27xaJU3QFuQZqADmh=ZseiN=Y1WCFPk4v4RzizK=2Xtg@mail.gmail.com>
 <xmqqlhjb13s3.fsf@gitster.dls.corp.google.com> <54F986D6.5000607@drmicha.warpmail.net>
 <CAP8UFD2qGBPiNaDmx1OELM45TZqSqKkHZkdVOqupWKKxPxbvOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	"git@sfconservancy.org" <git@sfconservancy.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 18:03:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTvfG-0007Iy-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 18:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbbCFRDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 12:03:50 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:43321 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbbCFRDt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 12:03:49 -0500
Received: by oibg201 with SMTP id g201so18677674oib.10
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=R7dsJkoygtqMKrWhUBZKK/7syJIykwNZ6esIeXl1s90=;
        b=U9R/SbYYKPhrjB5BmCGgQvnJK9ztqQeO78VE0EbdvuddF8rj/gI4qKJ33kOdUwmmli
         /QLmO75C5KE/iHtgIIUOzPNKjAbpHBKG2tRz9fWnDeCBt9kjCq2TCfsOwFDaZzod3YxM
         y6E6j4vPcacivF4yvw/sF5VYAzHjc6rAKE7WL1yfws3sgjcjMZVllnHDlKKWvoF9Kakz
         zZNtMM6Wcx8GEgkfrI1hk9iNhOgmhkPOgvQdJ9h0AnhMLHTFo6FSm8vqd0etFhzGWrTZ
         zWDm4mzFFMlV/T7P0W9nhlxBTkTiwQ480/B4DkqrnJFbpibi9IWyac05MxaNI4E/1MPM
         m9nA==
X-Received: by 10.202.188.66 with SMTP id m63mr11184914oif.14.1425661428860;
 Fri, 06 Mar 2015 09:03:48 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Fri, 6 Mar 2015 09:03:28 -0800 (PST)
In-Reply-To: <CAP8UFD2qGBPiNaDmx1OELM45TZqSqKkHZkdVOqupWKKxPxbvOw@mail.gmail.com>
X-Google-Sender-Auth: KQuU2Um5oJIBBkvvUasR6sEzQz0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264942>

On Fri, Mar 6, 2015 at 4:55 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> I had more in mind the people who mentored GSoC students (and this way
> helped the Git project get some money)...

Just on this part, because I want to avoid giving a wrong impression
to discourage
potential mentors to participate and help GSoC.

The Git project does not require mentors to donate their mentorship
stipend to the
project. IIRC The pool started because the stipend was a small amount of money
($500 or so) that still counted as income to whoever is getting, and
all mentors found
it not worth their time having to deal with the hassle individually.
That is how our
association with Software Freedom Conservancy started: have a legal entity hold
such money as a non-profit.

If a mentor wants to keep his mentorship stipend, the Git project (the
legal entity)
is perfectly OK with that.

Of course, I am hoping that all the mentors are doing GSoC not for money but out
of love of our software and our community, but the above sounded as if you are
saying that the past mentors were robbed by the project and are
entitled to crawl
their money back. I just wanted to make sure that mentors will not be
robbed (and
the past ones weren't robbed) against their will.
