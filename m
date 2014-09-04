From: Shawn Pearce <spearce@spearce.org>
Subject: Re: mini-GitTogether Oct 2014? (was: Next Git conference or meeting)
Date: Wed, 3 Sep 2014 19:19:45 -0700
Message-ID: <CAJo=hJtprO6_NVNpJBGMm-3wTmWtfeyU-yc_UVZM7qPR-sGNsg@mail.gmail.com>
References: <20140903210907.GB28644@peff.net> <xmqqfvg8wf3y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 04:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPMf3-00020r-CP
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 04:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837AbaIDCUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 22:20:07 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:52986 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820AbaIDCUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 22:20:06 -0400
Received: by mail-ig0-f180.google.com with SMTP id hn18so322183igb.7
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 19:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4osXwPZVsNObCgAXe1t8W7CuD8LfgFEkjeROX6UlUR8=;
        b=U6YyIFBV75wF6ZYEJTvOg5EQs2/+F74Brgy/neRBYOTw4MAw80417Omj/5+FqD0fV6
         +YBiaSuZAE1241jmS6P/hCBrbYE89uNITuvNDxeOxIlR0a3Sdle0bNgXfbbCEeq05geH
         Nu/J2D7MH+Ghpoq2GHwXj5YTfTs5f4KsJ1J58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4osXwPZVsNObCgAXe1t8W7CuD8LfgFEkjeROX6UlUR8=;
        b=G5yBQL8Ms4Oz4aZO9Zkh62y5rXTubbudgaTqTvhNrBtguarTzkhldQ9t4W/jxjADkp
         cqbZK0AjrHvi7e9c8tvpv0cXSjKpUUC0l/MaC75KfczDofZYLqBRAxBXQex03nJIVz4z
         siYhWS9XiQ7f8F/SoVMtNvqtd1lpj6MPAdlnM06A5t/TQicFAvcJw6oDFmDh032EX0cz
         UT9uR77Q8C1DHNTo545pmVcbPhXmQVnhHVXisf80PbD0VapMYtvHFTf4Fuxfzh7ZGiOZ
         fzvXtOB29DSvJBFHRjfUyp/9W7yKPv3yaei9+I5lUNOKN6mzSMqbTxhTY7qCcf2iX6ix
         jTmA==
X-Gm-Message-State: ALoCoQkAp22jimPvD3jOXcbdmdyItun91/bsypzUzvcKIVsP4fdqd7l9Awx25/4M8+lfnK8hTl9c
X-Received: by 10.51.17.66 with SMTP id gc2mr1672049igd.40.1409797205374; Wed,
 03 Sep 2014 19:20:05 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Wed, 3 Sep 2014 19:19:45 -0700 (PDT)
In-Reply-To: <xmqqfvg8wf3y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256434>

On Wed, Sep 3, 2014 at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I know you are talking about something potentially much larger than
>> this, but I wanted to note that Michael Haggerty, Ramkumar Ramachandra,
>> and I will all be in the Bay Area for the GSoC Reunion, October 23-26.
>>
>> I do not think we want to have a "real" conference, but I wonder if git
>> devs would have an interest in getting together for dinner or some
>> social time either right before or right after.
>>
>> I'm thinking it would probably be small-ish (<20 people), and primarily
>> just for people who work on git to talk to each other in person.
>
> I guess I'd be close enough to come.

I would be interested if its 23rd or before. I hop a plane to Germany
on the 24th. :)
