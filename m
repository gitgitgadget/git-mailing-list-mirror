From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 11:57:06 -0800
Message-ID: <20130218195706.GD3234@elie.Belkin>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <20130218185801.GA25673@sigill.intra.peff.net>
 <CALkWK0kFYP4k5=237PZ3XHhxkzF-RWwwe=3+Thb_xU2Jw5tg2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:57:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7WqI-0008UO-AF
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122Ab3BRT5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:57:14 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:55909 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757003Ab3BRT5N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:57:13 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so2597823dad.24
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 11:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=g5e2I5rp6e6AbNurf2V8RCijy0ls/3mL8GLJo/QXdyE=;
        b=ItHONk04qp5FkiDUrW4BnwQtc87bWgghecf5kdm8VhvNIPOXSCtPW+ruuCGnpw2RxB
         dsuXNYBCkw5ASWp8fSnbjCr3s/cVX08Mwl0G/be1jbRGwj330E1jrEw01aqpW37Af4QN
         GeSIZ69rICahhop9ZzzZp1NiYuj6AWsVAiWN9EKqMfPBHacoofpba83V396cvWRk8FTx
         +WpucaAGGyfJuYU0oD+T3XDEr2zfKFUm+E1KYFVr1H3plwm0V9fGPI+fWlPIq1J0BLsa
         sGd2PGyTuOaizx3qyWE9IEUZSbnR4Wo3Fi6uvMKFkFPh3zsq1EX4oehTALX8La/gkjg/
         Av9w==
X-Received: by 10.68.227.129 with SMTP id sa1mr32703294pbc.107.1361217432220;
        Mon, 18 Feb 2013 11:57:12 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id gf6sm15363919pbc.24.2013.02.18.11.57.09
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 11:57:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kFYP4k5=237PZ3XHhxkzF-RWwwe=3+Thb_xU2Jw5tg2g@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216508>

Ramkumar Ramachandra wrote:

> Take what I'm about to say with a pinch of salt, because I've never mentored.
>
> Mentors often don't provide much technical assistance: students should
> just post to the list with queries, or ask on #git-devel. Mentors
> serve a different purpose; their primary responsibility, in my
> opinion, is to teach the student a sustainable productive workflow.

I basically agree.  One of the most important jobs of mentors is to
make sure there are people available to provide prompt technical
assistance, hopefully before the project begins.

[...]
> - using gdb efficiently to quickly understand parts?

Oh, dear.  I hope not. ;-)

Thanks,
Jonathan
