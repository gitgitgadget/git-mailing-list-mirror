From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Next Git conference or meeting
Date: Wed, 3 Sep 2014 10:15:15 -0700
Message-ID: <CAJo=hJs-wvT4fPA0Ad0tuOjBth0aRzbEFX6pu7N8Uq4TdToZgw@mail.gmail.com>
References: <CAP8UFD1Jzy2jzRaFh35=y1yCJcMHKSkXbSXp1SuBL2R2bQAJqQ@mail.gmail.com>
 <1A6AAC8B-0C82-4296-B1C8-BF0739A28A80@gmail.com> <20140902112117.GB5049@thunk.org>
 <20140902135147.GC6232@thunk.org> <CAP8UFD3x1Pm-+0GF+2CEFkZ34XDzZ95Wu0boPgGocE_8T7uk9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:15:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPE9w-0001zl-T8
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 19:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945AbaICRPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 13:15:37 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:45609 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbaICRPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 13:15:36 -0400
Received: by mail-ie0-f180.google.com with SMTP id rl12so10156495iec.11
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hbmwTzM3kNwVq0D6OgX9YBYjmEQabOOmBfWPTQgT848=;
        b=XsPJOh5C7Wq8sgkiNKl2oMDpvPaUdHX93OtDmQwdB4d+7Nduas0sl+mnfUQrWa9sv5
         QFeq5L+JNin3+hii6hGgfTQmENQ0x2klCrf3VtrR2UVxXjlbVgTtmRJbwXNRuBbFc/T6
         gdIesjVcNLIr1v2Quzl8NzOKYBIcLOXf5uyNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=hbmwTzM3kNwVq0D6OgX9YBYjmEQabOOmBfWPTQgT848=;
        b=geM0FQd7ToGGgHEHX5GdboeU2ulTSS4l/npjaY9ELDJnOGTtERa2KGfleObHS0Fg9d
         1v0/FlMxJo1Qdonm6NOdLCitYUZrGhzg64DS9ZxEizkQ0E1jeRnfPk1dkxRA5A745rp8
         zL5cOhklUHUauQbdhmV/LnaCcVFfWbu+XLJ1djHtUTFX8kA1sld66A6x32E2Lsy+Og0M
         buikzEaGDXVtR275tQjynEFkkuW4+UU47iN4tUkucXqy04jQV2ymV3xpoqkWI4sdWPeV
         w4Gy1PPMQmUOPdDx2nN3c8ikPiJTT2wwp7sAY8kifMpPXin5kODtHr6QSBNDkXDCNINx
         ABpg==
X-Gm-Message-State: ALoCoQmSNlZYXxaa9I1UfiXYpg0luTfKp78zkST6bpAkwr5QAIzybwf8vx0tePSMamB4vumxMKAI
X-Received: by 10.50.6.68 with SMTP id y4mr21765289igy.47.1409764535722; Wed,
 03 Sep 2014 10:15:35 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Wed, 3 Sep 2014 10:15:15 -0700 (PDT)
In-Reply-To: <CAP8UFD3x1Pm-+0GF+2CEFkZ34XDzZ95Wu0boPgGocE_8T7uk9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256398>

On Wed, Sep 3, 2014 at 1:53 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Sep 2, 2014 at 3:51 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>> On Tue, Sep 02, 2014 at 07:21:17AM -0400, Theodore Ts'o wrote:
>>> On Tue, Sep 02, 2014 at 08:20:42AM +0100, Luca Milanesio wrote:
>>> > Hi Chris,
>>> > Seattle is a very inconvenient location for most of the people
>>> > coming from Europe: somewhere in the Bay area would be better and
>>> > less expensive for us.
>>>
>>> Well, the fact that Seattle is inconvnient might not matter that much
>>> because apparently large numbers of Europeans are on vacation in
>>> August, and some of them are already complaining that the Plumbers
>>> Conference is going to be colocated with LinuxCon in Seattle.  :-)
>>>
>>> The Linux Foundation will be hosting its Collaboration Summit (which
>>> is like LinuxCon, but which is invitation only to members of
>>> developers community and LF members) in at the Hyatt Santa Rosa August
>>> 21-25.
>>
>> Oops, sorry, I meant to say April 21-25; hence four months earlier
>> than August, avoiding the European vacation season, and also requiring
>> a flight into SFO.
>
> I am ok with having the GitCon at Hyatt Santa Rosa around April 21-25
> if people prefer or if it makes it easier for the LinuxFoundation.
>
> It's true that it can be cheaper for Europeans as it may be easier to
> find a free place to crash at (hi John!)

I think he was really referring to airfare. SFO is a major US airport
with decent direct route coverage to major sections of Europe. I think
getting to Seattle often requires landing at JFK or Dulles or SFO and
then connecting with a US domestic flight. That adds significant
travel time and cost to any trip.

> And April 21-25 is closer to the anniversary date. On the other hand
> there might be fewer people around because the Collaboration Summit is
> invitation only.
>
>> If this is something that folks are interested in, I work with Angela
>> pretty closely, since I organize the Kernel Summit, so I'm happy to
>> put folks in touch with her.  But before I do that, I have one other
>> question.  Has the Git conference/meeting outgrown Google's
>> facilities?  Is that an option?
>
> As far as I know, the big problem with using Google's facilities is
> that someone working for Google needs to be involved and spend a lot
> of time talking and organizing things with other Google people. And
> unfortunately the Git developers working for Google are usually very
> busy with other things like working on what they are supposed to work
> at Google. Shawn used to organize the GitTogether meetings, but he has
> been involved in Gerrit during the last years and therefore cannot do
> it anymore.

I don't think we have outgrown Google's facilities, but I could be
wrong. We can usually accommodate about 150 people for an event if we
plan ahead for it. We just can't surprise the catering folks with a
large same day food order. :)

But yes, I have been busy with $DAY_JOB and that has cut back on my
time for community event planning.

I hadn't realized Git is turning 10 next year. Just been too busy
using Git to pay attention to its upcoming anniversary. Let me talk to
some folks at Google and see if we can organize something here in
Mountain View, or help the LinuxFoundation sponsor something.
