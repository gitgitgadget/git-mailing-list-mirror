From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Wed, 17 Feb 2016 19:32:05 +0100
Message-ID: <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:32:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6tb-0001hb-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933380AbcBQScL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:32:11 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34538 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149AbcBQScK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:32:10 -0500
Received: by mail-wm0-f42.google.com with SMTP id b205so168294169wmb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/43xtCou6kLuP1N6zW0hlSdAqC9zgiSO/w7o/ad/5Fg=;
        b=EZHVpny1DDzH4f6w25b9xg5Sen1kQXb4vuFuy0PyiWbaYQ50n9FgeJajsO2/lFQFLz
         3FP6F7omykzCVObGnOAbbdHtZXhK9W8zFs4Xv2u9OTTaTCxA5ERweIcbxUSEYrjJUDSL
         4CO6ukHIDxYc2tvt+buhWnYxD91EFHRNbHkUIBQipHjZXuy2x43wdaAvaDPNTqEhnzQg
         GA/v4G/WeqjfLF11xZrutt6skXHYebv3YetCxBxQ9RdWtUM19pXl6wKZDgoRf5ngKX34
         8sh7yWukj/A/n8mp0xbssO90gqWQ0uo2g+CTPBhsq1p/VwIIoRycH5KBv45BWTWYrmF8
         NC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=/43xtCou6kLuP1N6zW0hlSdAqC9zgiSO/w7o/ad/5Fg=;
        b=lWihz/Si55U1uzO4W8izonTIpZkFndsbFqKgdG7b8dZzsrryqe/P680vyJpM7GIYdc
         4LU2/FINh4tmbi4CyJJh+JR2XokEpLhIqm8IaGutNGKNcooo46hY2u1fYM+DzWmgREle
         OeVS+RCRiQj8JiVDcxAEKXZWM/ymioGjnlfoCfvRihdmE7Srlg8lMXVfwv1aAmzbBl6W
         c52VYL3S6l3figGuwe6fzCIoGsdhUro5SZDuP6D2kikH7DHDu22mvyHJ5IV+SJoQqqf1
         YCRwcpKalSknzueDnfkC5YpCzu4ks4WaBLOOr7VwJQb7P0Rst52OhG82HvKyBi61N1gY
         gtmQ==
X-Gm-Message-State: AG10YORkrWEdwkT0wvukQyFMnwWe3ByPnYDmykvur/Iu/xzG5MKMvixdHb3I7SZe/l6rtg==
X-Received: by 10.28.131.141 with SMTP id f135mr26549325wmd.33.1455733928894;
        Wed, 17 Feb 2016 10:32:08 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB412D.dip0.t-ipconnect.de. [93.219.65.45])
        by smtp.gmail.com with ESMTPSA id s8sm2750239wje.35.2016.02.17.10.32.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:32:07 -0800 (PST)
In-Reply-To: <20160217172407.GD1831@hank>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286532>


On 17 Feb 2016, at 18:24, Thomas Gummerer <t.gummerer@gmail.com> wrote:

> On 02/10, Matthieu Moy wrote:
>> Work on the application itself, and on the list of ideas.
> 
> One potential idea:
> 
> Make destructive git commands more safe for the user.
> 
> Some commands (e.g. git reset --hard, git clean -f, etc.) can
> potentially destroy some of the users work.  Store the information
> that we are potentially losing somewhere, where it's easily
> retrievable by the user.
> 
> This should probably be hidden behind a new config variable
> (core.iKnowWhatImDoingButIReallyDont or something better), as it has
> the potential to really inflate the repository size (when storing
> binary files that should be deleted by git clean for example).
> 
> It happened more than once that I thought I knew what I was doing, but
> would have been really glad if git saved me from my mistakes.
> 
> I haven't thought this through much further than just the idea, so it
> would be great to hear some opinions on it first.

Coincidentally I started working on similar thing already (1) and I have
lots of ideas around it. I get endless requests at my $DAYJOB of messed
up Git repos where people just pasted stuff from StackOverflow without
a deep understanding of what they are doing.

If the lists agrees to take this topic for GSoC I would be happy to 
co-mentor it.

Cheers,
Lars

(1) using Git config hacks

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
