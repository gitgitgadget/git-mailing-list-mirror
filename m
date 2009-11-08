From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: gitk : french translation
Date: Sun, 8 Nov 2009 22:41:30 +0100
Message-ID: <20091108214130.GA12931@vidovic>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com> <b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com> <9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com> <20091107025439.GC13724@vidovic> <9f50533b0911080955l606ea87aw4edd7b0bc926a25f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 22:41:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7FW9-0002dk-VN
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 22:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbZKHVlb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 16:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbZKHVlb
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 16:41:31 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:35678 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbZKHVla (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 16:41:30 -0500
Received: by ey-out-2122.google.com with SMTP id 25so93586eya.5
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 13:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nwbL2LbcKS7bmPFcxNpQApk+C9Tm6z6cTBFT8N2qLWA=;
        b=cFc2+WA16jF4NRgRwxWZeNewiLfyaG/X6WMkArM/PbNwTYGVGHSl/CGzNdiChVQy8s
         VqB+2MfD/wqT+h++EPiw48jR1Wak9aNQrEqWP53WYP/aHl4+IVnWNXryGTLVLfewQbIX
         1jW9WSjUUPla9oe93koIOVWP1ysGQ3SfuEFiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Zc9ISkbPueB0irKjDBpipPzn18Uc3KOxEnQTyMRC5aGRcAol7Yip4nJaqzwjVRVT8q
         LIqiSutTsLRJEbiR/55WwgzSDiZ2DqjqzRKO6QfQcYoa16OU5bDMYCO3tYtlBGfZep/9
         o7/C5LI6yxuI/wnlPKg36RrVgb7FOHuwOI408=
Received: by 10.213.24.25 with SMTP id t25mr8030275ebb.98.1257716494921;
        Sun, 08 Nov 2009 13:41:34 -0800 (PST)
Received: from @ (88-122-119-54.rev.libertysurf.net [88.122.119.54])
        by mx.google.com with ESMTPS id 7sm325506eyg.1.2009.11.08.13.41.32
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 13:41:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9f50533b0911080955l606ea87aw4edd7b0bc926a25f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132420>

The 08/11/09, Emmanuel Trillaud wrote:
> 2009/11/7 Nicolas Sebrecht <nicolas.s.dev@gmx.fr>:

> > [
> > =A0Please, conform to Documentation/SubmittingPatches of the git.gi=
t
> > =A0project and send your patches inline to make the work for review=
ers
> > =A0easier.
> >
> > =A0Both of your patches lack the Signed-off-by but maybe you don't =
want
> > =A0them to be merged?
> > ]
> I am aware of this recommendation but this translation is almost 22kb=
 and
> I tought that put it inline wouldn't make the review easier. I will
> submit a patch
> gathering my workand those of the reviewers soon.

Thanks, it will really help. If the patch is very long, you could split
it into more patches for the review purpose, maybe relying on the
semantic fields. Regardless you split it or not, inline patches are the
good way to contribute here.

Side note : you _must_ have the signed-off-by from Thomas if you want t=
o
use his work.

Oh, and please, submit the new version in this thread.

> > I disagree here. Words like "diff", "commit", "patch", etc should b=
e
> > kept as is. Translation of those terms make things harder for the u=
sers.
>
> I agree with you when those terms refers to _commands_ names, but the
> main goal of a
> translation is to _translate_ and we have to make the best effort to
> use french word if they _exist_

I don't think so. Here is _why_: the user-frienliness of a translated
software comes from "how hard is it to connect a word with the
underlying concept".

IOW, we want to have good words to refer to the _concepts_. In the
computer science world (and more _specially_ for a SCM), those concepts
are much more well-known with the english terms. Keeping english words
help users to directly understand what it is about, without making the
users have to search for "what the fucking translators are refering to
here?".

> and _are_ appropriate (that's why I'm not sure about translate
> "cherry-pick" by "ceullir").

I don't have strong opinion for this one because :
- the translation is good enough to be directly understood ;
- where "cueillir" (or so) is used, we have the fallback to the english
  term between round brackets.

> I prefer to translate "Diff this -> selected" by "Diff=E9rence entre =
=E7a
> et selection"
> because it is what the user do when he make a diff.

Looks ok to me, except that "Diff" is better than "Diff=E9rence" for th=
e
reason I give above. A "diff" is clearly about a _patch_ where
"diff=E9rence" may be used to much more concepts. French people don't u=
se
the word "diff=E9rence" to talk about a diff, they use "diff" as is.

> because it is what the user do when he make a diff. I am also ok to
> translate "merge" by "fusion"
> because it's what "merge" is in french and I don't this we mislead th=
e
> user by using the term
> "fusion".

I don't have a strong opinion on this because both english and french
words are known. That said, I tend to think that the english word is
better here too.

--=20
Nicolas Sebrecht
