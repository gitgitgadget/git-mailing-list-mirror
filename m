From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 12:28:35 +0200
Message-ID: <CALbm-EZhCOvO+RiFs9A+eb-Qri8_1tphCH1JkVo1iWTc3Qcp8Q@mail.gmail.com>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
	<CA+55aFwf9iAKxbvdPV9Up_T709KwBXJWW4g-F829CRQP4YkivQ@mail.gmail.com>
	<53707b5955034_2b5710592f8aa@nysa.notmuch>
	<5370825f709ef_a8114c1304e2@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git-fc@googlegroups.com, Richard Hansen <rhansen@bbn.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Dusty Phillips <dusty@linux.ca>,
	Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Christophe Simonis <christophe@kn.gl>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 12:28:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjnTN-0002Ij-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 12:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbaELK2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 06:28:38 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:65100 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbaELK2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 06:28:37 -0400
Received: by mail-we0-f174.google.com with SMTP id k48so6518024wev.5
        for <git@vger.kernel.org>; Mon, 12 May 2014 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=79MB/ElAhDASaKDI2s2PBI9jD1Rukcwf5VcApCBbS8k=;
        b=KQZvw1tEhzQ6JprBXrOqh5tw0q0Rj5G5SifEKZNzdG/W9tcYhhzzXG6Otor4ohEuLX
         oJW3qTOldGRd/8icxiXUjbKwTHX3NHnt6uQQ218w1K/rBhTB/diGYmnEZdKQ9gFno/7D
         w9xuF5d9T38PJolsicj5NQfydlD7wziuRHSMrd+P8myYpIrhPzczHTfgfSfwRdwg4y33
         gBenkq/+qzruZ6Yg7H7vltCc3vxY3WXhkBEsfXG1jFgHqp51/r95HRTmZ0C77MmLixBf
         X5RMJ7xgg+I6AkECtaLH7+rm24nzUAueR4n1HnQLzbyB3II4oWviYVf96WfMyWOGilW9
         PpFQ==
X-Received: by 10.194.205.35 with SMTP id ld3mr604509wjc.82.1399890516039;
 Mon, 12 May 2014 03:28:36 -0700 (PDT)
Received: by 10.180.94.166 with HTTP; Mon, 12 May 2014 03:28:35 -0700 (PDT)
In-Reply-To: <5370825f709ef_a8114c1304e2@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248694>

2014-05-12 10:12 GMT+02:00 Felipe Contreras <felipe.contreras@gmail.com>:
> Felipe Contreras wrote:
>> Linus Torvalds wrote:
>> > Felipe, stop this stupid blaming of everybody but yourself.
>>
>> Show me evidence that this decision was my fault. Junio certainly hasn't
>> said so. You just have no idea what we are talking about.
>
> Here, let me show you.
>

I suspect Linus had a reason not to include the mailing lists
in the first place and make a huge public discussion,
but instead wrote to you personally.
I guess this is just Linus desire not to waste the time of everybody
as he learned that these discussions are fruitless sometimes.

Junio C Hamano wrote [in another thread]:
> I would not mind asking the others, as your discussion tactic seems
> to be "repeated voices start sounding like a chorus, and a chorus is
> project concensus".
>
> Those who are observing from the sideline, please raise your hand if
> you think the three-line "Clarification" Felipe gave us is a fair
> and accurate clarification.  Anybody?
>
> I also do not mind seeing hands raised of those who do not agree,
> even though I already know that they would be a silent majority.

I think Junio is behaving very professional unlike you, Felipe.
This includes being polite and very patient.
Also this includes weighting different reasons to make
informed rational decisions.

Git being a project widely used and people trusting it for their
work needs to have high quality and cannot go left today and
go right tomorrow, but most of the decisions are done long-term.

Felipe, this may be the reason, why you think nothing changes.
It's just slower than you'd like, but with more thoughts weighted.

Junio, I think you're doing an awesome job in maintaining Git
and leading the community.

Stefan
