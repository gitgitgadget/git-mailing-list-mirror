From: Stefan Beller <sbeller@google.com>
Subject: Re: git-scm.com website
Date: Mon, 9 Mar 2015 10:54:33 -0700
Message-ID: <CAGZ79kZx1LRhiJacG9oNnpRSmG40jyp48AqC+3M7bt0hkbVdEA@mail.gmail.com>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
	<87y4n6kvdu.fsf@fencepost.gnu.org>
	<CAP2yMa+Bw0KCSz9YEtviZUykAp4jpdsEWSK-jRxtd9MjzjHKfg@mail.gmail.com>
	<87lhj6kqng.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Scott Chacon <schacon@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 18:54:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV1t0-0003JQ-Ld
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 18:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbbCIRye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 13:54:34 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46336 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbCIRyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 13:54:33 -0400
Received: by iecrd18 with SMTP id rd18so14692080iec.13
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r8DkC29GlZO+Sp4Uq2vFDmPbLnl+EOtB3F/ad9MyZM0=;
        b=OxRogejAjM/dH6pGR/a33ncp9r5xFl6ZwLsIjpqyuerJsCEsPH1ebyegdrSgGLre19
         hsOjN5zEJP7v33C2KtgWSNZJ01IdPN622InTPqz60S7CGCxeIO5Hh3bdCG0G0IlIVfU0
         83JBR02lF4/jnQAp2AGtoj+2AChZXJbkZ2EZHRoCkDQ9/YZc9t0K28C4w2ZCMX+CsnAh
         26KBtU1Km/gkB1axJTgH7t5Nk84aX+aTUCV7O5LSfeAFzx+BABhTCQegwntvcsPyC3yj
         infin8QJoX1XK+yl5T1IS1UUi89CX3XZdHJngvq70X1axK4sXLHYx1jjx9Nba1S0sOya
         cf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=r8DkC29GlZO+Sp4Uq2vFDmPbLnl+EOtB3F/ad9MyZM0=;
        b=XSsN0DD4rUH2i0FdtCvXajn4FPnmogHVFMmFQAA6UfTSQfaILaoz4e/HEpEttwGlyy
         w+GykQA1k+A6rG4Ulee6Cu3sjAL+Sdeni8Zhc7JZh8wS1ciWwCiOAgYeHgt3pB2cQt+I
         yLYpg0XAfybpuBbaY+LJPmtyCdX851vE9cLM9ZRwjxSEqewUxx0LONeZEFle7AxIg4j8
         wk5tmJDakyCkwB4srbTTvRENbnzXg04wkKfvaljEFULXQGsgONvrlU2ue8O2fSNwkJe8
         /sy14Z1Vrca+eT75o2MSjF/PLkKkRi2OnLARooTaLwZ/ORbh7NZo/v+CPzF9Sd6tXW3F
         ooQg==
X-Gm-Message-State: ALoCoQmEnJnNao3ztgmlMzXrtFM80sNXFkpRFnC7ZEPgZD0i2+xqxPnVQLlmCvLb6M3VNZvQg4Fg
X-Received: by 10.50.254.4 with SMTP id ae4mr49433280igd.10.1425923673207;
 Mon, 09 Mar 2015 10:54:33 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Mon, 9 Mar 2015 10:54:33 -0700 (PDT)
In-Reply-To: <87lhj6kqng.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265186>

On Mon, Mar 9, 2015 at 10:49 AM, David Kastrup <dak@gnu.org> wrote:
>> since many people coming to the page are doing research to figure out
>> if they want to switch to it in their companies. It also demonstrates
>> that these large companies are participating in the open source
>> community
>
> Uh no, it doesn't.  "Uses $x" does not constitute participation.
>

I am unsure what the intend of the site is or should be?

Do we want to convince other people to use it as in "everybody
else uses it, so should you" or rather point out you can participate
in the (development-) community as in "we got contributions from
these companies and projects, you could also steer git in a direction
you want by participating?"
