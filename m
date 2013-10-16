From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Wed, 16 Oct 2013 20:06:19 +0200
Message-ID: <CALWbr2zMrUL0cmtYuoGZ_Sm33i29fJRdJtDZmd6kR_KrabU+PQ@mail.gmail.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
	<87wqon7ok4.fsf@igel.home>
	<7vli52uym0.fsf@alter.siamese.dyndns.org>
	<20130720002241.GA22143@sigill.intra.peff.net>
	<CALWbr2w7XCuD5tUSwR+Cwv4wyXLk8MHDGyU2Dr+jA9vOfDYqig@mail.gmail.com>
	<20130908080311.GA25498@sigill.intra.peff.net>
	<20131016175621.GA4308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 16 20:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWVUK-0004J3-FB
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 20:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935186Ab3JPSGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 14:06:22 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:41050 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934655Ab3JPSGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 14:06:20 -0400
Received: by mail-qe0-f50.google.com with SMTP id 1so936451qee.37
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sYge6yU2y8gMf2V8IzE8mHrQQzLUd+oZhbSXRfOVXo0=;
        b=F0+HU4tdVYzJHgjSwLj1LiJZoSyq2j1fASIJ8zm+NK5f+tb6O1Zw0n9JJg7Qq5Advb
         C02euu5Wvy60qli0QvqXNCnboMAcWqsGrc1JXmCZREOD+ugFB4xG/5kPa/igIgAiUM4H
         pxdhSnGAWwEGMTgLjY2eniB6ymoXkjdSP2eczw4wv/3K385iuv0J7SR0zjTvsdWHWUy3
         Q54yXAoQ4CqnrdG0liiPyO5DwoGJFixfDX1V1fEOgEhyqIEFP881RNxvzgHRA1dOI09w
         dMo4lUJCJ3I9/dV8YpOuHfsii62uXSRBPLLDR9tRAneGTcVxvWhWqCyMz958niIeug6d
         fZXw==
X-Received: by 10.49.94.226 with SMTP id df2mr5784906qeb.76.1381946780061;
 Wed, 16 Oct 2013 11:06:20 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Wed, 16 Oct 2013 11:06:19 -0700 (PDT)
In-Reply-To: <20131016175621.GA4308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236251>

On Wed, Oct 16, 2013 at 7:56 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 08, 2013 at 04:03:11AM -0400, Jeff King wrote:
>
>> > I have some free time to come, and would like to work on that feature.
>> > Does the offer still hold ?
>> > If it does, I would be interested in your patches.
>>
>> I'm sorry I have taken so long to get back to you on this. I was hoping
>> to revisit the topic and make sure the patches were in a sensible state
>> for showing to somebody. But it took me some time to get around to it,
>> and now that I have, they're really not looking very good.
>
> Hi Antoine,
>
> Since I haven't heard anything, I assume you haven't been working on
> this. But in case you have, I wanted to let you know I found some time
> and moved the topic forward a bit. It's not quite ready to share with
> the list, but I wanted to notify you so we didn't duplicate effort.

Unfortunately, I didn't have as much time as expected to work on this topic.
I'm glad to hear that it's moving forward and will definitely have a
look when you send the patches to the list.
Thank you for letting me know,

Cheers,
Antoine
