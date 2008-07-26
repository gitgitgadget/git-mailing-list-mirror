From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Sat, 26 Jul 2008 00:27:32 -0700
Message-ID: <d411cc4a0807260027t4b9c3b08x1f865ec75d976ef6@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <20080726015314.GU32184@machine.or.cz>
	 <20080726020951.GV32184@machine.or.cz>
	 <7v4p6dnv5k.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0807252343n2b9ade68veaebb68664f0a3d7@mail.gmail.com>
	 <7vtzedktmi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 09:28:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMeCi-0003I7-Cm
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 09:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbYGZH1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 03:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbYGZH1d
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 03:27:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:36444 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbYGZH1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 03:27:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3751631rvb.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wWrZj1m3obzVjJCbEfyLdpbF3tOWdPLvLhs2naDP+Lw=;
        b=tTIogyHXZyxD6syg1Wvd504Hla59Kj3Sy8gKrycgADdGX8UCp60Fn3V9FvdMEB2Ng8
         rWwVFK/23CCKecK1Ex6fACud0XSA92vChOyYq2ljRCGrPpRLpgkh/71Rf0CV7/YoP15u
         n1Es2uWGGWWieukaSVNK+pO2JTO/J8LAZzzc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KxD7HchWgQMI+V7YTsgTZD8CsyKb9uq0tvOpzL/018NAjYDDs7D13//wYJnUY6caCx
         U0Yr2REkVvWETa1lgD8tWffu+LDiPgfaTVN44cyeYbc4PYc5kfLn3iyRoKajRMs8hbv8
         7UFn61ZUdZU7FFHnjpxX7N+e8B+XCtloq4zFg=
Received: by 10.114.124.1 with SMTP id w1mr2972491wac.73.1217057252674;
        Sat, 26 Jul 2008 00:27:32 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Sat, 26 Jul 2008 00:27:32 -0700 (PDT)
In-Reply-To: <7vtzedktmi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90192>

Perhaps it would be useful to split the mailing list into core/contrib
and support lists?  I would be happy to help out answering questions -
a lot of them come directly to me anyhow because of the gitcasts site
and such.

Scott

On Sat, Jul 26, 2008 at 12:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Scott Chacon" <schacon@gmail.com> writes:
>
>> On Fri, Jul 25, 2008 at 9:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> ...
>>> These two are directly related.  They might be friendly and well-meaning
>>> folks, but I agree that they haven't earned our trust yet.
>>>
>>> But I do not think it matters that much.
>>> ...
>>> It's also somewhat interesting to observe that several people I have never
>>> heard of in the git circle are simultaneously doing new git books,
>>> apparently never asking for much technical advice from core git people, by
>>> the way.
>>
>> To be honest, I have asked for a fair amount of technical advice from
>> many helpful people in the IRC channel over the past few years.  In my
>> case, one of my best friends - the guy I've been working with for the
>> last 4 years - is Nick Hengeveld, who has something like 50 commits in
>> there - why email the list when I can yell a question over the cube
>> wall?  I'm sure you all have more important things to do than review
>> my book for newbies - I asked Nick to do it.
>
> Ah, Nick.  We haven't heard from him for quite some time.  I've actually
> been missed him from time to time whenever http related issues came up.
> Please say hello to him for me ;-).
>
>> If I could code C worth a lick, I'm sure I would have contributed more
>> to this list, but since I have nothing that I feel would be helpful to
>> you, I've passively followed the list.  I'm sorry that you do not
>> consider me a "git community member" just because I don't code C, and
>> so I can't contribute helpfully to core.
>
> I realize I may have sounded somewhat harsh, but that was not my
> intention.  And I do not think what you said is fair, either.
>
> We have had quite a few end user questions on this list, but I do not seem
> to recall any of the names of the book writers, whose books are presumably
> aimed at these people, answering them.  Granted, core coders may be busy
> bunch of people, and the questions and comments from new people sometimes
> tend to be lost in flurry of patch floods.  I and other core coders would
> have greatly appreciated if non-coder experts like yourself helped these
> threads that have never panned out.
>
> I am not complaining.  This cuts both ways.  The patch floods do tend to
> discourage new people from asking basic questions, and lack of answers
> even more so.  But it is not healthy for people who design and code not to
> hear end user feedback.  I personally would want to see the list traffic
> to be inclusive.
>
> The people who design the new features and write code should have easy
> access to the issues the users of all levels have with the software and
> the documentation (and what they find useful as well).  What I am most
> afraid of is that both "We do not bother the coders" and "We are too busy
> to answer every newbie question" mentalities would lead to a fractured
> community.
>
