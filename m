From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFH] hackday and GSoC topic suggestions
Date: Thu, 6 Feb 2014 10:10:05 +0100
Message-ID: <CAP8UFD1B+108EyyhFQh6RnVVpOUCLiK+oNPONrNJqkNftLFYLA@mail.gmail.com>
References: <20140205225702.GA12589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 06 10:10:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBKyO-0006Fp-L5
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 10:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbaBFJKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 04:10:09 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:47751 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbaBFJKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 04:10:07 -0500
Received: by mail-vc0-f181.google.com with SMTP id ie18so1197911vcb.40
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 01:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PufykxA3FDDXEcLanFgXaijjqyTSenklDC9ZrtmMl18=;
        b=BgZd1A3SbOl8QSPJm6ZGEVnlI4FRgfZ5myjyWYmRVcRsTXQ9a7bufWS/U05716Byp/
         tQlf6OzOM9boewytlO9IjprAD649+wiKaJfTUeFNPT9Y89Oeg1fIj07FNkjYQTwmAOBd
         vic3UNX5GIbV2IDSlYBf1J3pF6gj12JtfNz4IGfNi3CXmDoL7/GywC09VlSMxWjvtCMq
         5//OwqqjJalZS34XRCtb6SelaGyvoPQPHXtlWf3BKrTAgUwW3xv83MWtGBSuXbbiVBiY
         TmJ26F8cSGOmcOWscH4OP2uHA3iTLJKWFpnhqX6lJb9kJigU4u568c1Wi0ROGbXB0jFj
         2MLw==
X-Received: by 10.52.30.230 with SMTP id v6mr4156543vdh.6.1391677805637; Thu,
 06 Feb 2014 01:10:05 -0800 (PST)
Received: by 10.58.173.231 with HTTP; Thu, 6 Feb 2014 01:10:05 -0800 (PST)
In-Reply-To: <20140205225702.GA12589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241684>

On Wed, Feb 5, 2014 at 11:57 PM, Jeff King <peff@peff.net> wrote:
>
> On a similar note, the GSoC application deadline is Feb 14th. I am
> happy to be admin again and put together the application, but we will
> need an idea page. I'll set up a page to collect them, but in the
> meantime, please dump any ideas/discussion in this thread.

Matthieu Moy created this nice page some time ago in the wiki:

https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

and I think there is good stuff in it.

I would be interested in mentoring a GSoC student working on the "git
bisect fix/unfixed" feature.
Some of Matthieu's students worked on it a few years ago but didn't finish.

Thanks,
Christian.
