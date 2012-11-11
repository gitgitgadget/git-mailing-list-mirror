From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Sun, 11 Nov 2012 14:40:48 +0100
Message-ID: <CAMP44s2s9qL_ytb3vvrh02M0zWXyrE2Mt25bBi4Y_+Ur=5C4TA@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
	<CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
	<CACnwZYekU0CYnqQT8L2siJbUsn=T9qowgth94TWc8KN472Ziag@mail.gmail.com>
	<CAMP44s2P-nhAGgj9nuJ3cKqb6+enAthwiUNS8QTZn8MP1poJ2g@mail.gmail.com>
	<CACnwZYfP4=Fvt8T0GOEzjTOaEyYF_Ao6e_f02eqO_5_DyzM0Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 14:41:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXXmc-0007IX-Ds
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 14:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab2KKNku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 08:40:50 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57280 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab2KKNkt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 08:40:49 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5463436oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AAKjqXj7eIe4bkvAeNq+sYzH3g6mSxRo3Qh89CPuTnk=;
        b=MeClCURUDLVbaLqvgDOPiV2hQfJFepA+boELOI2x0YjgIXG6w2JbvtZOnVJSQeS53Q
         lPHDOL5EQmNkuMZcRE60Lr/rBvXM7kBU0k9dQr5jY3xhazKj02JqCIsb7whIgx4WRtzx
         Fc141SrRPfn6nZG26+0DiUeajCvFVyyQHxfAT/9VqNtWI7IdHWWRJAd+6Vqfs1VKKGWG
         71qK+jzsZEu3MssVjI/ok+ATmnIXvQ77EiJS+LgBIlhgWnLe/adt3PtJ28kw5YMl4xmx
         ndsFhNNjegrW7CZLVnCfVpjfdj4AwUqSjPUtjrAUsBSArQQyaZ8HP7ZEOWjxJECpkyQJ
         y1wQ==
Received: by 10.60.32.19 with SMTP id e19mr12601273oei.9.1352641248734; Sun,
 11 Nov 2012 05:40:48 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 05:40:48 -0800 (PST)
In-Reply-To: <CACnwZYfP4=Fvt8T0GOEzjTOaEyYF_Ao6e_f02eqO_5_DyzM0Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209353>

On Sun, Nov 11, 2012 at 2:09 PM, Thiago Farina <tfransosi@gmail.com> wrote:
> On Sun, Nov 11, 2012 at 10:14 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Requiring everyone to use a web browser would limit the amount of ways
>> people can review patches.
> I don't see that as a limitation as I think everyone has access to a
> web browser these days, don't have?
>
>>> How come that can
>>> be an impediment to move forward way of this awkward way of reviewing
>>> patches through email?
>>
>> It's not awkward, it's the most sensible way.
>>
> The most harder way I think?
>
> Look at this:
> https://gerrit.chromium.org/gerrit/#/q/status:open+project:chromiumos/platform/power_manager,n,z
>
> There I can go and see many informations that through this mailing
> list I can't or have to do much more work in order to archive this.

That information has nothing to do with reviews. That's patch state-tracking.

> If you open one of the 'patches' you can see some relevant information:
> - Who is the owner/author
> - Was it verified?
> - Is it ready for landing?

Irrelevant for git.

> - If I click on Side-by-side I get a nice diff view interface that
> plan text email does NOT give me.

Not useful.

> - Was it reviewed/approved (+1, +2)?

You can see the same in a mail thread.

> - It can be merged by one click.

Irrelevant for git.

> - The interface also provide the command line to download/apply the
> patch for me.

Not useful.

> - Isn't there a reason (implicit there) for Google being using tools
> like Gerrit/CodeReview(rietveld)/Mondrian for handling his code
> reviews rather than solely by 'email'?

Who knows And if there is, who knows if it's valid.

And none of those points has anything to do with code *review*.

All these points are about state-tracking, and that can be implemented
*on top* of the mailing list, for example through patchwork:

http://patchwork.newartisans.com/patch/1531/

That's if somebody actually cared about that, but that doesn't seem to
be the case.

>> You just replied to my mail the same way I would reply to a patch.
>>
> I replied through a web browser by the Gmail interface. ;)

Indeed, Gmail is one of the many ways you can review a patch.

You clik reply, you add the comments in line, and click send. Couldn't
be easier.

>>> There are a lot of issues of having to use email for reviewing patches
>>> that I think Gerrit is a superior alternative.
>>
>> There are no issues. It works for Linux, qemu, libav, ffmpeg, git, and
>> many other projects.
>>
>>> And many people are arguing for it!
>>
>> Nope, they are not.
>>
> If they weren't then nobody would be suggesting to use Gerrit for
> handling the review of git patches.

Except you, of course.

> But I think the big resistance comes from the fact that the core
> developers handle/review the git patches through Gnus/Emacs, so that
> is enough for them and they don't want to make the switch because of
> that?

gnus/emacs/notmuch/thunderbird/Gmail, and pretty much every mail
client out there.

Cheers.

-- 
Felipe Contreras
