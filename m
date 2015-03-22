From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Draft of Git Rev News edition 1
Date: Sun, 22 Mar 2015 21:50:53 +0100
Message-ID: <CAEcj5uV0adYn_F6D1mmueR5F8N459dgP1TTWmPiEH9NFeDqFeQ@mail.gmail.com>
References: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
	<CAPc5daVU77hpsWeJb9BhvHW9YwoSVb8Jgc38zZ9xEnx0cB2QDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, David Kastrup <dak@gnu.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dongcan Jiang <dongcan.jiang@gmail.com>,
	Jeff King <peff@peff.net>, Doug Kelly <dougk.ff7@gmail.com>,
	Bharat Suvarna <bharat.bs84@icloud.com>,
	Kevin D <me@ikke.info>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 21:51:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZmpn-0003Pg-Ky
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 21:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbbCVUuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 16:50:54 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36137 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbbCVUuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 16:50:54 -0400
Received: by qgez102 with SMTP id z102so42907450qge.3
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i0UglX0DBIHwv2HcfntY1rsyPyn+M1AvOt4Pj02lghQ=;
        b=e2FmgZ+eApIofOx9O2aMVMuJxqSITD/Gajm/oHkiMd+qQQAGS15x335wL0ORcq0uTJ
         m2RBEikh41cR+/EIbQ7H8EXs6TEpZIK9gPqX9uR0HcCR6Ab6bRJEZODBW2H2whdtYOlf
         w5YfvsL++7mz+57N1Xh5ehSm3GIKeo6ZtU+tHYYBnZU+SVgBU5Sc4cC7mCbiONh7z0w2
         0NvOaysBAeOEAym+Ucr1j5Khm6fvJQeJXnuORHhspH1PaEyOylrYSnLCVFbkNqjuihkV
         AFhlMRPhVBWUMfME6DTxN1amFCpJOke/ZdRW1K8W3J9Pnt9aOM7+OpYsA3NY1+8dYFvW
         cYOw==
X-Received: by 10.140.129.65 with SMTP id 62mr117313554qhb.11.1427057453281;
 Sun, 22 Mar 2015 13:50:53 -0700 (PDT)
Received: by 10.140.102.55 with HTTP; Sun, 22 Mar 2015 13:50:53 -0700 (PDT)
In-Reply-To: <CAPc5daVU77hpsWeJb9BhvHW9YwoSVb8Jgc38zZ9xEnx0cB2QDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266092>

On Sun, Mar 22, 2015 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.
>
> The most important question I would ask you is this:
>
> Did you two enjoy writing it?

To be clear, apart from some minor wording and nitpicking, I only
contributed the links from outside the list. This is an activity I
mostly do regardless, either on Twitter or at Google+. Gathering the
links in Git Rev News just means I collect them in a central place
instead of sporadically posting on social media. So I think I can keep
it up for an extended period, and if I ever get fed up, there are
hopefully others who can keep that part going.

Refining list activity into headlines, like Christian did, is a bigger
challenge in my eyes. I think this depends on having someone active on
the list, who also has time for producing this reader's digest.

I guess the long term success depends, as with any volunteer effort,
on how many others join in the fun, and how popular it gets outside
the list.

>  - As a periodical, you would want to have "This edition covers
>    period between these two dates" at the beginning of each
>    and every edition. Publication date may serve as the upper
>    bound of the range, but for an inaugural one, it is essential
>    to have the date the coverage begins.

Good point. There hasn't been a decision on frequency. Weekly is a
good rhythm for publications seeking readership, but that's a lot of
work. My vote is we should first aim for a monthly consistent release.
I'll try working this into the draft, and Christian may change as he
sees fit.

>  - As an inaugural edition, we may want to have a word on
>    the purpose of the publication. Perhaps a sentence or two
>    to declare what the publication is about in the "Welcome to"
>    section is good. I would imagine that the primary purpose
>    is to cover the discussions on the list (but don't call that
>    "the list" in this paragraph, but spell it out to help readers,
>    as "the Git mailing list") that is not visible in the "git log"
>    output from my tree.

Noted. I'l try working this in as well.

>  - As an inaugural edition, we may want to have a word on
>    how it came in existence by covering the discussion that
>    led to its birth. Perhaps the discussion that led to the
>    publication should be made into as an item on its own,
>    next to "make git-pull a builtin", "Forbid log --graph..." etc.
>    Because it is neither a review nor a support discussion,
>    "Reviews & Support" heading may want to become
>    "Discussions". I think that is a better title for the section
>    anyway, if its purpose is "what happened on the list that
>    are not visible from "git log", as I expect future editions
>    to cover design discussions that advanced the shared
>    understanding of a problem but not quite solidified to
>    become a patch series.
>

I hope it's OK that I leave this bit to Christian.

Thanks for the feedback!
