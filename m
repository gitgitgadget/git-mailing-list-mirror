From: Stefan Beller <sbeller@google.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Tue, 16 Feb 2016 10:10:38 -0800
Message-ID: <CAGZ79kbUG73eo5YvedbVB0bmZduMeCWNpbCRK4Adr9XDebsbQQ@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
	<vpqd1s2e74l.fsf@anie.imag.fr>
	<20160212130446.GB10858@sigill.intra.peff.net>
	<vpqd1s04zzs.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 16 19:10:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVk5E-0001Aa-7X
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 19:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbcBPSKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 13:10:40 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35647 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374AbcBPSKj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 13:10:39 -0500
Received: by mail-ig0-f173.google.com with SMTP id hb3so79162725igb.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 10:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pvZPG+3FShb5JElS2v8HoZ+HlPhqLZp53ZHoVrEcPcw=;
        b=cX61p3E5ddE6pvB0ez2RsjRsK6Nfgjzj79Si5fOwhnccX5l9VhbUxCLf68nysgKg9X
         dLFXs92fyF3W++QuJGfvgeMeukWV3g2X27lVpIlP/Key6TvevZu4Glhvhs53Uvt4jTS+
         WyiKNJvuFwtEbiGmmhVCzsLcMMVSGbwGUCEiiNcYC/TucfbsQMxbD0YQucr0F7vadNQu
         ZQ+aaajTeTOI/yKpfcjwUzEcHOUdEwtpQdVRdg4W1SZ5Mm3Y0YmL/JJu4F+ZCE8GFfWO
         f7xy8JaRm758GSW4f71JfYWp6emYkPvHk2wMFLzohiTFne+qtMC+EBLsEjaGDRDRO9xS
         Xgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pvZPG+3FShb5JElS2v8HoZ+HlPhqLZp53ZHoVrEcPcw=;
        b=IhJ+oWVc+AL7kLUnHQN6Lb5B+CRgLQVO/VDSdD3P82xe+s0DFzdsst7evpa39pT/fT
         oAY4yW6GXvhX8ixMeAXo8WuxijQ+3Mf6BANwZEoC2uhzhqMVbZfFUcIlYRtdMq0RgiiT
         3KDSTiXD9Oci7FNkoSALE0Ax5tNmFFCUENBZrT0qxgIJmlo8nwr/G1xGzD+Rfh4hF3gn
         /9wib75m+PXr/KvspXwbFPUrJ2ZjZiXB67WvtTRbAmHVeqGePLt0c/g3r+pcqMnk28DH
         BmEL2KdCx31Z3lTp+C4KDBaoTDCtYv4UO7GiHgoxYuub6dRuQ7lJ2qvUjhS7HMJFOE2n
         gRCg==
X-Gm-Message-State: AG10YOTU5lisE7WI6hBZJmBDvl3+sWQ1hRU4yCaSSiQXNpW0SwUsYBln0yEounZCjj0PDG96CEczFy80S0wLbrIY
X-Received: by 10.50.80.14 with SMTP id n14mr19880257igx.85.1455646238979;
 Tue, 16 Feb 2016 10:10:38 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 16 Feb 2016 10:10:38 -0800 (PST)
In-Reply-To: <vpqd1s04zzs.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286410>

On Sat, Feb 13, 2016 at 3:21 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, Feb 12, 2016 at 08:10:34AM +0100, Matthieu Moy wrote:
>>
>>> So, that makes it 4 possible co-mentors, i.e. 2 potential slots. Not
>>> much, but it starts looking like last year ... ;-).
>>>
>>> Peff, would you be willing to co-admin with me (that would be cool, you
>>> are the one with most experience here and you know the SFC stuff for
>>> payment)? Are there any other co-admin volunteer?
>>
>> Yes, I'm willing to co-admin (though I'm also happy to step aside for
>> somebody else if they would like to do it).
>
> Cool!
>
>> The biggest task there is getting the application together. I went
>> through the account creation steps at the site (which is different this
>> year), and the application questions are:
>>
>>  - Why does your org want to participate in Google Summer of Code?
>>
>>  - How many potential mentors have agreed to mentor this year?
>>
>>  - How will you keep mentors engaged with their students?
>>
>>  - How will you help your students stay on schedule to complete their projects?
>>
>>  - How will you get your students involved in your community during GSoC?
>>
>>  - How will you keep students involved with your community after GSoC?
>>
>>  - Has your org been accepted as a mentoring org in Google Summer of Code before?
>>
>>  - Are you part of a foundation/umbrella organization?
>>
>>  - What year was your project started?
>>
>> I think we can pull most of these answers from previous-year
>> applications, but I haven't looked yet. In years past we collaborated
>> on the answers via the git.github.io site, and I pasted them in place.
>
> I started working on it.
>
> http://git.github.io/SoC-2015-Org-Application/ => the application itself.
> Mostly cut-and-paste from last year, but the questions have changed a
> bit. There's a "Remarks on the current state of the application" section
> at the end for stuff I wasn't sure about.
>
> This is the urgent part, we won't have an opportunity to modify it after
> the deadline.
>
>
> Less urgent, but we need to add more stuff to be credible:
>
> http://git.github.io/SoC-2016-Ideas/ => Ideas page. I removed the
> completed project, and updated some other to reflect the current state
> of Git. I think "Convert scripts to builtins" is still feasible this
> year, but probably harder (we can't say "start with git-pull.sh"
> anymore ...). Johannes: you're still interested I guess?

I'd be interested to co-mentor a sh->C conversion.

I think the git-rebase*.sh is a good start.

$ wc -l git-rebase*.sh
  101 git-rebase--am.sh
 1296 git-rebase--interactive.sh
  167 git-rebase--merge.sh
  636 git-rebase.sh
 2200 total

So start with rebase--am and rebase--merge to have the same amount
of lines as git-pull.sh. I did not look at the code, just judging by
the lines of
code.

git-rebase.sh with 636 lines of code is quite a lot I would think.

Then there is also git-bisect.sh with nearly 700 lines, which is also not
as easy.

Thanks,
Stefan

>
> http://git.github.io/SoC-2016-Microprojects/ => I just did s/2015/2016/.
> I think most projects are not valid anymore, and we need new ones.
>
> To all: please contribute to these pages, either by sending patches here
> (CC: me and peff), pushing directly if you have access, or submitting
> pull-requests. The repo is https://github.com/git/git.github.io/.
>
> Thanks,
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
