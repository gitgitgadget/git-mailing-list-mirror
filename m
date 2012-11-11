From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Sun, 11 Nov 2012 12:11:42 +0100
Message-ID: <CAMXnza0xcH0M53BEaEyvEnShz5fGLjOtgxmTC9YMGtBsR8ratw@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
 <CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com> <CACnwZYekU0CYnqQT8L2siJbUsn=T9qowgth94TWc8KN472Ziag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 12:12:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXVSm-0005Uy-9S
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 12:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548Ab2KKLMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 06:12:05 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59674 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab2KKLME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 06:12:04 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5388482obb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 03:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lwMcD9nPWhFOX3oBLpGAmdelUcGNechG2x7eX1kDMC4=;
        b=BuETz6u2u+ycJ6D8X00y7+wyoHj720X3ChDys2N52u4kb6b0Hx5LIQVz4ha1GfzZ0h
         kS8gfrObbI880d33u0/vRzVskZ/+FcGm4YDJ0azdCOktWcjtbO1M5A0JJCqGkPYLmzbl
         Sh3OlKItyDZm3qacR4XLnqGV7HHtRVZTXVgTbBUgh1oWqb7lSTi0hUU9y21gaPM3kYzr
         hVmeyNdkdty5K05V2cu6xYa5Rr7kAeLJUX2lwbJ9+82OcvEGgjO3YzeUhBhyXjtclfOo
         BXI8KRDbW+/8nuQx7N2ncaMlCDH+1HxcZh6JW45DW9lGDz/P2bvx8975HGeta2JBKJdr
         /KrA==
Received: by 10.182.18.142 with SMTP id w14mr12953761obd.65.1352632322871;
 Sun, 11 Nov 2012 03:12:02 -0800 (PST)
Received: by 10.60.57.162 with HTTP; Sun, 11 Nov 2012 03:11:42 -0800 (PST)
In-Reply-To: <CACnwZYekU0CYnqQT8L2siJbUsn=T9qowgth94TWc8KN472Ziag@mail.gmail.com>
X-Google-Sender-Auth: pNapIJFu9Az7o1tJMHtRUjiqbJk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209337>

Hi,

On Sun, Nov 11, 2012 at 2:13 AM, Thiago Farina <tfransosi@gmail.com> wr=
ote:
> On Sat, Nov 10, 2012 at 9:40 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sun, Nov 11, 2012 at 12:19 AM, Deniz T=C3=BCrkoglu <deniz@spotify=
=2Ecom> wrote:
>>
>>> This is my first mail to the git mailing list. I have been followin=
g
>>> the list for some time now and I would like to suggest moving the
>>> reviews out of the mailing list, for example to a gerrit instance, =
I
>>> believe it would improve the commits and the mailing list. I have a
>>> filter on 'PATCH', but I feel I miss some of the discussion, and
>>> things that I would be interested in.
>>>
>>> I have spoken to Shawn Pearce (gerrit project lead, google) and he
>>> said he is OK with hosting the gerrit instance.
>>>
>>> I would like to hear your thoughts on this.
>>
>> Personally I think reviews on the mailing list is far superior than
>> any other review methods. I've even blogged about it and all the
>> reasons[1]. Gerrit is better than bugzilla, but it still requires a
>> web browser, and logging in.
>>
> Requiring a web browser is a huge requirement, ham?? How come that ca=
n
> be an impediment to move forward way of this awkward way of reviewing
> patches through email? Switching to Gerrit would mean everyone would
> be using the same tool instead of anyone using its own email client
> (gmail, mutt, thunderbird, whatever...) and having to figure out git
> format-patch, git send-email (--reply-to where?).
>
> There are a lot of issues of having to use email for reviewing patche=
s
> that I think Gerrit is a superior alternative.
>
> And many people are arguing for it!
>
> Let's move on...


I'm just a user, I found this discussion intriguing and was wondering i=
f
any of you have heard of patchwork server[1].  It is a patch aggregator
for mailing lists and provides a convenient bug tracker like web
interface without getting in the way of the workflow of reviewing
patches on the mailing list.  If you are interested the Org mode
community (an Emacs library) uses it.  You can take a look here:

  <http://patchwork.newartisans.com/project/org-mode/list/>

I just thought this might be a nice middle ground for people.

Cheers,


=46ootnotes:

[1] <http://jk.ozlabs.org/projects/patchwork/>


--
Suvayu

Open source is the future. It sets us free.
