From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] gitk: Remove tcl-format flag from a message that
 shouldn't have it
Date: Tue, 10 Mar 2015 12:53:42 -0600
Message-ID: <CAMMLpeQWTzAsWwX2rsVhGLz4ZMcEsZw=auGeUeYow-P2kCM3Sg@mail.gmail.com>
References: <1421914779-30865-1-git-send-email-alexhenrie24@gmail.com>
 <CAMMLpeTvtzPuiQJVxAx-Ja4JsoUxih5azMaN7_RcLvajny6A6g@mail.gmail.com>
 <xmqqlhk6agxg.fsf@gitster.dls.corp.google.com> <CAMMLpeR6TkZxFQBVJukC3KgXM-cJkRY31m8OthHxMkaZzLqGjg@mail.gmail.com>
 <CAMMLpeQ0fyNm1pdF6iDBzh8q__g6H8Obgwg3mD680CydmCwfVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Git mailing list <git@vger.kernel.org>,
	patthoyts@users.sourceforge.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 19:54:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVPIA-00061T-16
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 19:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbbCJSyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 14:54:06 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:34180 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbCJSyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 14:54:05 -0400
Received: by labgq15 with SMTP id gq15so3891047lab.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 11:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vpVSTct0CVwvD+zwq83/nT5Mlhwn/k+qlpMEIS0l01U=;
        b=hvFT/5YxFZ1qfj91qebdCdos0I0IxpOfUu7HocvrDzcvGOEZQAw/mu72sn0I5yGF5b
         T4gQMAsU5P1uaWJ/3sUD1ngE8/vGJEfqBJ6556zqKO1slL0/INzc4kNBNykswZjQMJYd
         /frWdosaRFVAV/9SgGInxB8tJSq4GrQGqhXnxcZUEIbr9at9pJijLaH2PcKYEVX5z0AT
         uOJKY172/NwbcP/MPvt3xkoBZGtu+ooEvn2QZB1lkcerJ8xX3tWH4WU+cSZt253HqvxI
         VvmMx0ivwX9iwqr7HEQT9pcq+Ml6GL9zDYOY0LLlNBauvSjmKhsUBGEJoxEb4ZdcvVBb
         kdHA==
X-Received: by 10.152.19.9 with SMTP id a9mr32097058lae.80.1426013643125; Tue,
 10 Mar 2015 11:54:03 -0700 (PDT)
Received: by 10.112.146.42 with HTTP; Tue, 10 Mar 2015 11:53:42 -0700 (PDT)
In-Reply-To: <CAMMLpeQ0fyNm1pdF6iDBzh8q__g6H8Obgwg3mD680CydmCwfVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265254>

2015-02-23 15:30 GMT-07:00 Alex Henrie <alexhenrie24@gmail.com>:
> 2015-02-16 16:27 GMT-07:00 Alex Henrie <alexhenrie24@gmail.com>:
>> 2015-02-09 14:55 GMT-07:00 Junio C Hamano <gitster@pobox.com>:
>>>
>>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>>
>>> > This is just a friendly reminder that this patch has been sitting in
>>> > the mailing list archives for a couple of weeks, and it has not yet
>>> > been accepted or commented on.
>>>
>>> I think that is because the message was not sent to the right
>>> people, and also because the patch was made against a wrong project
>>> ;-).
>>>
>>> I'll forward it to the gitk maintainer after digging it out of the
>>> archive and tweaking it.  Thanks.
>>>
>>> Paul, comments?
>>
>> Another week and still no comments on either this patch or the gitk
>> Catalan translation patch. Is Paul Mackerras still actively involved
>> in the project?
>>
>> -Alex
>
> Another week and still no response. If Paul is no longer maintaining
> gitk, another maintainer should be appointed.
>
> -Alex

I am unsubscribing from the Git mailing list. As far as I can tell,
the gitk project does not accept patches, not even translations into
new languages. If this policy ever changes, please email me directly.

-Alex
