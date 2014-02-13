From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFH] hackday and GSoC topic suggestions
Date: Thu, 13 Feb 2014 10:28:02 +0100
Message-ID: <CAP8UFD3pqW119xjY0Wci7bJ6UL4ZLsT_vYZJ=zMsnK_7C8-_KQ@mail.gmail.com>
References: <20140205225702.GA12589@sigill.intra.peff.net>
	<CAP8UFD1B+108EyyhFQh6RnVVpOUCLiK+oNPONrNJqkNftLFYLA@mail.gmail.com>
	<vpqr47gin5x.fsf@anie.imag.fr>
	<20140213085039.GA29152@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 10:28:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDsau-0000tX-I7
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 10:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbaBMJ2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 04:28:06 -0500
Received: from mail-ve0-f173.google.com ([209.85.128.173]:62394 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaBMJ2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 04:28:03 -0500
Received: by mail-ve0-f173.google.com with SMTP id jw12so1086140veb.4
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 01:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JVZasjo8hmJnBQ79Sv0Mzp6wHiEMWW1Kq0HQRnm7EYw=;
        b=MlN0rRD60w+RDtmFOKJWijljy/juHi62eGMlxqXQ24H0LRnM+plJbt+OJj+sjY/cs9
         X+oOQ9kLYFuBTkf5bpv38R4T/3US92HP4o+4Ny0Vlxp3YPPR/aktJCLtBXOjM4QQgup2
         MEJ5J5ooxoqfbEkO61VKibniBKUKTQef1b/m46BQD1MKhuwDqLlKh7FfNTBRDDQAOQod
         bmP1XaahDqGJB4qwc0goUH6fyJcpZNyBqFoVUtJLOKwKNUQ7yZoJXFt3t8kbPxj01EyG
         FtSjSIm1UAOcBB07+9na2WnpO3TKEAmTII1rCGniCiLSc3BoiYHRaN5gvX6G+0tt3PK4
         hMGw==
X-Received: by 10.52.84.102 with SMTP id x6mr141441vdy.49.1392283682810; Thu,
 13 Feb 2014 01:28:02 -0800 (PST)
Received: by 10.58.104.129 with HTTP; Thu, 13 Feb 2014 01:28:02 -0800 (PST)
In-Reply-To: <20140213085039.GA29152@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242054>

On Thu, Feb 13, 2014 at 9:50 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 06, 2014 at 10:51:54AM +0100, Matthieu Moy wrote:
>
>> > Some of Matthieu's students worked on it a few years ago but didn't finish.
>>
>> Right. There was still quite some work to do, but this is most likely
>> too small for a GSoC project. But that could be a part of it. I'm not
>> sure how google welcomes GSoC projects made of multiple small tasks, but
>> my experience with students is that it's much better than a single (too)
>> big task, and I think that was the general feeling on this list when we
>> discussed it last year.
>
> I think Google leaves it up to us to decide. I'd be OK with a project
> made of multiple small tasks, as I think it would be an interesting
> experiment.  I'd rather not do all of them like that, though. And bonus
> points if they are on a theme that will let the student use the ramp-up
> time from one for another.

Yeah, a student working on the "git bisect fix/unfixed" feature, could
fix git bisect testing too many merge bases, and if there is still
time work on moving more code from shell to C.
