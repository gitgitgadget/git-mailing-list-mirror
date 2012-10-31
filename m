From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 17:11:39 +0100
Message-ID: <CAMP44s2PDZwTW55NDho9DyB2XZmsG0-KH4e78grJ2OFRVZkfjg@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<509149D9.3070606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 17:12:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTatW-0005Db-21
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 17:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935777Ab2JaQLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 12:11:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33076 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935724Ab2JaQLk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 12:11:40 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1582117obb.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RRbvAbTIbvR/8pMTdMwkbjnj+lHKLSZwBDKesPLz0h0=;
        b=v73LkWOlXm1YfQX6ZwMjvxN1vkvOLg9N2+biRC4zgGjMg52DCtdLqBAM2VnsYEbIbB
         P+mHfIvVi5mbZ9ardQvK+raPVYDd986NygNDf+1UwDLlm57x8G33Bq0Cn/+C/1K3oodm
         KLHgmT3WT56jyZrEiST9M7ppf57ymR5EDczcObuzbajSHGZekX6NkpdYDb2vj8XpJfcO
         ws0qpqT7kYMtrqsZBqjr7jQEOdo7iHP16y6RU4x+WFeNtTyHGIw0N9eiyvLnPXFhMUf5
         FjlP7gdGsOlYRhMVD40WujskUokuzycue8Q8aZlCx4L6K2ga1HMvZTQuL0s/cF2TTwQr
         Q2pQ==
Received: by 10.60.32.19 with SMTP id e19mr32933011oei.9.1351699899589; Wed,
 31 Oct 2012 09:11:39 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 09:11:39 -0700 (PDT)
In-Reply-To: <509149D9.3070606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208837>

On Wed, Oct 31, 2012 at 4:55 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 31.10.2012 16:39:
>
>> This is precisely ad hominem; you are ignoring the code, not because
>> of the code, because of the person. This is as ad hominem as it gets.
>
> I am not rejecting your code (I reviewed an early series) but reject the
> communication style and manners displayed in this thread.

All right, you are not rejecting it, but you are staying away from it,
and presumably if it was coming from somebody else, you wouldn't.

>> As for how "professional or helpful" that is, it's debatable. The
>> Linux kernel mailing list is known for being harsh, and yet, they
>> manage to get more things done than any other. They truly look at the
>> code, just the code, they don't consider criticism to the code
>> personally (nobody should), nor linger on any personal beefs that only
>> distract from the end goal.
>
> There are people who choose not to be on that list because of its style.
> For this list, I think we should follow this list's style, not that one.

And what is this lists' style? I don't see any guidelines anywhere.

But my point wasn't that we should follow Linux's style, my point is
that it's debatable how one should engage in discussions.

And yet, I haven't seen where exactly did I throw those ad hominem
attacks. I can point you to where Johannes threw such attacks (or at
least snarky), to me, but I don't think that's relevant.

>> But enough about Johannes, if I go on to Max's branch and give a try
>> to the code, make a list of issues, run my extensive tests and so on,
>> and make a report of the status, and a comparison with my code. Would
>> that make it more likely for you to stop being a by-stander?
>
> Sure, that's what I and others have asked for.

Except nobody ever provided a link to the actual patches. You are the
first one to do so.

>> You accused me of ad hominem, now I ask you; can you ignore any
>> personal biases and look at the code, and only at the code?
>
> My efforts here prove that I either have no biases or ignore them. I'm
> not going to ignore the style of communication, though.

And yet earlier before you said in this list "we prefer to discuss the
code, just the code", and now you are saying you are not going to
ignore the style of communication, which is not code, and yet you are
discussing about it.

> As a patch
> submitter, you ("generic you") want the attention of others as
> reviewers. It's in your own (again "generic you") interest not to put
> them off, in the same way as it's up to the submitter to argue why a
> patch is desirable and correct.

Ah, so you are making me a favor by reviewing the code?

How about we concentrate on what's good for the project? Our users
don't care about petty personal beefs. Support to pull and push
mercurial repositories, _that_ they do care about.

Cheers.

--
Felipe Contreras
