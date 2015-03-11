From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: Promoting Git developers
Date: Tue, 10 Mar 2015 21:04:33 -0400
Message-ID: <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
 <54FDA6B5.8050505@drmicha.warpmail.net> <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 02:22:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVVLr-0001ps-C4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 02:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbCKBWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 21:22:15 -0400
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:44348 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751532AbbCKBWL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 21:22:11 -0400
X-Greylist: delayed 1036 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2015 21:22:11 EDT
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com [209.85.216.182])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id t2B14sSV032240
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 21:04:55 -0400
Received: by qcvp6 with SMTP id p6so6703571qcv.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 18:04:54 -0700 (PDT)
X-Received: by 10.55.26.2 with SMTP id a2mr54013612qka.100.1426035894722; Tue,
 10 Mar 2015 18:04:54 -0700 (PDT)
Received: by 10.140.102.73 with HTTP; Tue, 10 Mar 2015 18:04:33 -0700 (PDT)
In-Reply-To: <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-URL-Scanned: Yes
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265288>

On Tue, Mar 10, 2015 at 1:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> I don't want to write again about each of these points now. I am more
>> interested in discussing a good strategy to try to revert the sad
>> trend of Git developers being promoted less and less, because I think
>> that it is really very important.
>
> I would suspect that those who agree with you would appreciate if
> you or somebody volunteered to act as our CKDO (chief kudos
> distribution officer).  I do not think I have enough time to do that
> well.  One good place to start might be to scan the list and
> summarize something like the following on weekly or monthly basis,
> as these are not something you can get by pointing people to "git
> shortlog" output.
>
>  - Those who gave helpful review comments, "how about going this
>    way" illustration patches, etc.  Bonus points to those who helped
>    onboarding newcomers.
>
>  - Those who asked pertinent questions on common pain points, and
>    those who answered them helpfully.
>
> If you are more ambitious, the source of the kudos may want to cover
> activities outside of this mailing list (e.g. giving talks and
> tutorials at conferences, etc.).
>

I don't know how feasible or desirable this would be, but I'll offer
it anyway. In the Git release notes for something like "git foo
learned a new option --bar", a simple "(Thanks|Kudos) to John Smith"
at the end of each bullet point may be a good way to recognize
developers in a concise manner without needing to dig through the
output of "git log" or "git shortlog".

Or if that would make the release notes too cumbersome to review, what
about using systemd's method? systemd's release notes include a
"contributions from" section at the very end that lists everyone with
a patch included in the release.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
