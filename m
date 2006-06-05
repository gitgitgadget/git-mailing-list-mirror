From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH 0/27] Documentation: Spelling fixes
Date: Mon, 5 Jun 2006 18:48:11 +0200
Message-ID: <dbfc82860606050948t5c952f65m364a455e0e83ec8@mail.gmail.com>
References: <33723.2579863214$1149366476@news.gmane.org>
	 <7vk67xenfe.fsf@assigned-by-dhcp.cox.net>
	 <dbfc82860606041059l31605bc5j18ad2b35ea6f6dc0@mail.gmail.com>
	 <4484239C.7020608@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, Horst.H.von.Brand@inf.utfsm.cl,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 18:48:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnIFT-0007Ne-9E
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 18:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWFEQsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 12:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWFEQsM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 12:48:12 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:2092 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750741AbWFEQsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 12:48:11 -0400
Received: by wx-out-0102.google.com with SMTP id h28so746177wxd
        for <git@vger.kernel.org>; Mon, 05 Jun 2006 09:48:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=iFhRaH5KKal0JHGySE8QVtHhMu+GNlf4vYjWdte9XakCb4JMBE4HDGxuHCRM0eDR30WOLbRbwDRVf6T9fBn+bbdnTfvsWbd/TcNy18d4UXKVuVHYuLReKV1m+WyRTIotJwxcvFn8Hvftc2iv5f29NtODWa187f+MRC+Jz+rEevw=
Received: by 10.70.47.1 with SMTP id u1mr6268897wxu;
        Mon, 05 Jun 2006 09:48:11 -0700 (PDT)
Received: by 10.70.66.6 with HTTP; Mon, 5 Jun 2006 09:48:11 -0700 (PDT)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <4484239C.7020608@op5.se>
Content-Disposition: inline
X-Google-Sender-Auth: 488f10de1dc9ebf1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21320>

On 6/5/06, Andreas Ericsson <ae@op5.se> wrote:
> Nikolai Weibull wrote:
> > On 6/4/06, Junio C Hamano <junkio@cox.net> wrote:
> >
> >> Most do not seem to be typoes, depending on where you learned
> >> the language (XYZour vs XYZor; ok, Ok, and OK; ie vs i.e.).
> >
> > Where do you write "ie" instead of "i.e."?
> >
>
> Mailing lists, online conversations, tech docs written in code
> editors...

Do you mean that code editors usually don't let you enter a dot into
the buffer, or what?

> Compare with online'ish abbrevs (afaict, iirc, imo, fyi).

That's hardly the same thing.  Most people would upcase AFAICT, IIRC,
IMO, and FYI.

I wouldn't group "i.e." with such abbreviations in any case.  (Hehe.)

> > In Swedish, there has been a trend to remove dots from abbreviated
> > expressions, but it seems people are returning to use dots.
> > Personally, I find that dots make things a lot clearer.
>
> Swedish has lots of abbreviations where one "part" of the abbreviation
> consists of multiple characters, like t.ex.

And "bl.a.".

> When each character of the abbrev defines one complete word dots are
> just prettiness-noise, their presence or absence decided by the gravity
> of the meaning ("R.I.P." vs "ie"). Obviously, correctness never hurts
> but this is, on two accounts, punktknulleri.

Considering that people don't want to get stuck on trying to
understand what the word "ie" is supposed to mean in a manual page
they're trying to understand what some command does (this happened to
me), I really think that fucking with the dots is called for.

Anyway, the general guidelines recommended by "The Chicago Manual of Style" are:

Use periods with abbreviations that appear in lowercase letters; use
no periods with abbreviations that appear in full capitals or small
capitals, whether two letters or more.

One possible solution is to expand "i.e." to "that is" (or something
equally befitting) and "e.g." to "for example", "such as", or similar.

  nikolai
