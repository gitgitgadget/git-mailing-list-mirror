From: Stefan Beller <sbeller@google.com>
Subject: Re: Git at OSCON
Date: Sun, 12 Jul 2015 21:35:45 -0700
Message-ID: <CAGZ79kYaw5Cf9j6nTyYwFUnBnR418dAkocK4jD4JnCT-PsvVkw@mail.gmail.com>
References: <20150713040111.GA3693@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 13 06:35:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEVTC-0001TZ-2e
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 06:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbbGMEfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 00:35:47 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33008 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbbGMEfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 00:35:46 -0400
Received: by ykeo3 with SMTP id o3so185345309yke.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 21:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H+OWtEqhV5ByO8v5IXxFhtRKq9MT9fdYcAkUwTHHP9k=;
        b=QII3uPsMHrBbFv4bH5zmZqldPrJVamhlx7JhUGK/yYRoy85A2l+IlzHYgyPbX5jZwn
         ugL+s5/XmaaCx6oaFJwp+raPSRko0b+UjBt/DvXdIR31DuJ7DCbiw7lQqcp5a2tqA3iD
         UBVOpERHHXcxt4i6E7MZPtCAgZ0yBO1iWuqh/lA3Lp3KXARFkrosThpTF67ttYF4uXfm
         jlA0jkYxAg6hwWeynfpaEN7u1bSWup1R0QnDRanqak1exXjv0d1CsGfS2B6dgCO8APBV
         X+dubooZ418PU8fJFM9uk1oMCJR2C8Mj/s60QyMGah/BG15u/ENRszY9ktfZG3Nnxk+1
         FECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=H+OWtEqhV5ByO8v5IXxFhtRKq9MT9fdYcAkUwTHHP9k=;
        b=m5LGO0NY0oUALcQIazoxIEoymzX86gL6yJTUO7D7ZCOQ5hEwOOUwQHP0f1UNGW54Sf
         EVywo4VWT5kKn/Wvh3cDsygv39YSOWZUCZy1KMY4uf3uut22rPXarHrw/ex06BqZnQJ2
         VHs9CftixCIhj36lRpTHb+/lp8/WsCJkXJ6MOXYAMZIsbnBqYLzEZvT+/vpy1OFmROv6
         JYtmPI3BI/EKgVBVv0Bgzgay9mEBOHbwWc6SBwRPw0K/yFvt2sedv4WzxNxRyGtAOSIB
         aJGocoxKgLToy+4zaXUl0uxGAnv7vo7zqRGG0R6KXd1D3jeoFvhQi2mSKQGg2OEe8EL6
         QeKg==
X-Gm-Message-State: ALoCoQm6MMU7gkaVk7d35uIDwVN/RNDwzxRGh8q3tu3q3JgQw70QsKPa4IXjqZQbXAjXJqVuvQ4o
X-Received: by 10.170.55.1 with SMTP id 1mr19278503ykx.25.1436762146003; Sun,
 12 Jul 2015 21:35:46 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Sun, 12 Jul 2015 21:35:45 -0700 (PDT)
In-Reply-To: <20150713040111.GA3693@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273907>

On Sun, Jul 12, 2015 at 9:01 PM, Jeff King <peff@peff.net> wrote:
> OSCON is coming up soon (the week of the 20th) in Portland, and I want
> to let people know that there's going to be a small Git table in the
> exhibit hall, connected to the GitHub booth. I'll be manning the table
> both days (Wednesday and Thursday the 22nd and 23rd), telling people
> about how great git is and tricking^W convincing them to become git
> contributors.
>
> If you're a git contributor and you feel like hanging out at the table
> with me for a bit and preaching the gospel, please come by! If you're a
> fan of git, come by and we can chat about new features. And if you're
> not a fan of git, come by and throw rotten tomatoes at me!

I am not sure rotten tomatoes are fine for carry luggage,
so I'll see if I get some in portland. In case I cannot get some,
I'll just drop by to observe how many others could bring some.

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
