From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-scm.com website
Date: Tue, 10 Mar 2015 10:07:39 +0100
Message-ID: <54FEB45B.3020601@drmicha.warpmail.net>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com> <87y4n6kvdu.fsf@fencepost.gnu.org> <CAP2yMa+Bw0KCSz9YEtviZUykAp4jpdsEWSK-jRxtd9MjzjHKfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 10:07:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVG8n-0005ip-3u
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 10:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbbCJJHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 05:07:48 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38853 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751173AbbCJJHo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 05:07:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 2C791211DA
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 05:07:40 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 10 Mar 2015 05:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=kh/jqEv+cqBPJySV4eOoSQ
	GuNIc=; b=MPMFHaZL1/rPCHe4Geu0b3tP2SqDVX6TGN6s1qqy59RxkhOgvr5ESq
	jMB8eP90q/jL3EdOsFlsZi36VsV7LdMuKBSOQ8Xx692TSLQaBy02X5dY3iJsjRBf
	2OioTjgZSFEBMvOGN5nKppItYqqmTsA1a8nsqOnJIwdSRi804tWxM=
X-Sasl-enc: oPEiiccC4cBh1qHmz7hB0vfBGiiQAKRXUXvVyMPaXyRF 1425978461
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A097A680109;
	Tue, 10 Mar 2015 05:07:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAP2yMa+Bw0KCSz9YEtviZUykAp4jpdsEWSK-jRxtd9MjzjHKfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265219>

Scott Chacon venit, vidit, dixit 09.03.2015 18:14:
> Hey,
> 
> On Mon, Mar 9, 2015 at 9:06 AM, David Kastrup <dak@gnu.org> wrote:
>>> On Mon, Mar 9, 2015 at 6:57 AM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>>
>>>> Since we're talking business: git-scm.com still looks a bit like a
>>>> ProGit/Github promotion site. I don't have anything against either, and
>>>> git-scm.com provides a lot of the information that users are looking
>>>> for, and that are hard to find anywhere else; it's a landing page. It
>>>> just does not look like a "project home".
> 
> I'm sorry that you feel this way, but I've tried pretty hard to make
> sure the site is as neutral as possible. The only actual place the
> string "GitHub" occurs on the landing page is at the bottom where it
> says "This open sourced site is hosted on GitHub."  I don't even
> mention anywhere that GitHub pays for hosting it. Also, all the Amazon
> referrals from Pro Git sales are donated to the Software Freedom
> Conservancy and all my personal royalties are donated to charity. It
> also very clearly states that the book is free to read online in it's
> entirety (which is actually relatively expensive for me personally,
> since I personally pay the S3 hosting and bandwidth costs for all the
> eBook downloads).
> 
> I'm not sure why you think it doesn't look like a "project home". It
> has basically all the same information on it that you would find on
> any other project home page: a description, direct links to downloads,
> source code, documentation, a book, community and development
> information, etc. These are basically all the same things found on
> sites like http://www.gnu.org/software/emacs/ or
> https://subversion.apache.org/.

Since quotes from several people got put together here and below (which
I cut out), I'd just like to reemphasize that I "don't have anything
against either", as I wrote. Github has done a lot to promote Git - as a
business, sure, but why not, and Git as a project has profited from
that, too. It goes without saying that stating "Hosted on Github" is
appropriate, not just because git-scm.com is hosted there, but because
it shows what kind of services Git empowers.
And I don't mind a listing of companies that use Git - it's not an
endorsement of those companies, rather the other way round. (I hope it's
legally OK to use their names and logos for that, I'm not a laywer, but
I'm confident you've checked.)

"This is the web application for the git-scm.com site. It is meant to be
the first place a person new to Git will land and download or learn
about the Git SCM system." says the README, and that's what the site is.
A landing page for people new to Git. It's good that we have one.

Maybe my use of the term "project home" was misleading. What I meant is:
it's not a home *for* the developer community. That's just a factual
statement without assigning blame. For example, Documentation/technical
is not linked there, and the blog doesn't carry release announcements or
Junio's technical posts. Development discussions take place on the
mailing list, and when we talk about user experience, it's UI and man
pages that we have in mind, not git-scm.com. When we need a web page for
GSoC or such, it's "something on github" that at least mentally is not
part of git-scm.com.

Now, unfortunately, git-scm.com is also not *from* the developer
community, if you define "developer := git ml regular" (and not :=
mostly not) and look at
https://github.com/git/git-scm.com/graphs/contributors. There's probably
no point in going into the historical reasons for that - after all,
we're not all German ;)

Seriously, I think "we" could try to put more stuff on git-scm.com.
Having GSoC and microprojects stuff ported there would be nice, I guess
that would require someone who knows a bit about the underlying web app
to get the framework right.

Maybe there's a painless way to get release announcements or similar
posts on the blog, so that there is more visible activity? Or collect
some external blogs?

I'm a no-ruby-no-rails guy, sorry, but I'll commit at least to looking
over some content especially in the man page/documentation area.

Michael
