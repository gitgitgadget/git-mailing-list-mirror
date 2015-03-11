From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Promoting Git developers
Date: Wed, 11 Mar 2015 14:53:11 +0100
Message-ID: <CAP8UFD37v_zOjRkUPLy-ChDs=+NetsDY7Q14-4rYA-WhnTRYyA@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 14:53:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVh4Y-0000oY-8y
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 14:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbbCKNxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 09:53:13 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34275 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbCKNxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 09:53:12 -0400
Received: by iecsl2 with SMTP id sl2so29462263iec.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ibyw8PAIPsKPFnOHsJr1hW4X1l9z2mp8QMudb2jEw8Y=;
        b=MYr40opPYASgojhoT005w2giwciFEBp8IDbkPtN1xwC025PPSKxvj2m+ur8m5EOWRl
         PKZblUwBVjACEHQ07ej7kizzpkBKDnlVLMF5xEPLlUheQRqiZJQ3vZGOa4Qs5L155jXc
         haWoEiQpKD8j9DZHEuRZDj5ATOsnpATRHzxg4R/o63JwktJWzY2exIXTsv9SrUGEREAg
         99qI3FUeOm7HUFF0N0fFnZsJaOsFn+EQZK5aUsz6Ywv/V9tjWyjiRKhUmxhyAsPKXhyb
         eNSc9Z4R1yyWj0tBWwpXZUJ8k0J6dqC9A66gMaOywWAbxTvDaeYMfiLTIP8N3R+pCr2N
         rd1w==
X-Received: by 10.50.66.235 with SMTP id i11mr65938977igt.40.1426081991265;
 Wed, 11 Mar 2015 06:53:11 -0700 (PDT)
Received: by 10.50.245.144 with HTTP; Wed, 11 Mar 2015 06:53:11 -0700 (PDT)
In-Reply-To: <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265325>

On Tue, Mar 10, 2015 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
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

Ok, I can start something about this two points every week or every
few week. It would be best if I could get help from at least one
person as I think it is a lot of work.

We can perhaps use the Git Developer Site at
https://github.com/git/git.github.io to edit a new page
collaboratively that would be published on http://git.github.io/ and
after that send an email to the mailing list.

> If you are more ambitious, the source of the kudos may want to cover
> activities outside of this mailing list (e.g. giving talks and
> tutorials at conferences, etc.).

First I don't know if we should really give kudos (or badges) or have
something more like the former Git Traffic you talk about in another
email (or perhaps both).

And then I expect that if people give talks or tutorials at
conferences or publish a blog post or have other news they want to
share, they could edit the web page themselves on GitHub (or fork it
and send a pull request if they don't have the rights).

I also appreciate very much that you are willing to improve the
release notes by adding a summary with people's names.

It would be nice if we could also have somewhere on a web page at
least a good listing of the authors and how many commits they had
contributed (since the beginning and maybe also during the last year).
We could also add other listings made using the Helped-by and
Reviewed-by trailers.

I don't think we should rely on an external web site like OpenHub
(which is still giving me a 504 Gateway Time-out on the contributor
page) or even the (broken) contributor graph on GitHub for that. If
Scott and Peff don't want it on git-scm.com then it is of course
better on git.github.io than nowhere.

Thanks,
Christian.
