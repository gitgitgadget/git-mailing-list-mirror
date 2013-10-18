From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: My patches
Date: Fri, 18 Oct 2013 10:49:48 -0500
Message-ID: <5261589c855ea_30ce11dbe78d3@nysa.notmuch>
References: <20131012072450.GA21165@nysa>
 <xmqqtxgjg35a.fsf@gitster.dls.corp.google.com>
 <525c64ebe2390_197a905e84c@nysa.notmuch>
 <xmqq8uxrzn9h.fsf@gitster.dls.corp.google.com>
 <52605a36eef0f_448145fe7466@nysa.notmuch>
 <9A62D872-0FCF-41B9-B185-7061B25F1CBC@quendi.de>
 <52611e75bdc8d_2b6dcb7e7459@nysa.notmuch>
 <20131018153009.GA23704@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Max Horn <max@quendi.de>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 18:25:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXCrM-00028W-FH
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 18:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502Ab3JRQZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 12:25:01 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:48759 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab3JRQZA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 12:25:00 -0400
Received: by mail-oa0-f50.google.com with SMTP id j1so3546138oag.37
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=DBPtlF4yJO/6G1IeYKtOTH26LGNOs9bP8MMJOwCMLXI=;
        b=rmjfnt0Lt9vspKCCS/On31W4PeGaRKxX1sc/Piba9Zdv6juLZs6W13+oovHkzm2qow
         GCiGNNeh4x9j5Z+YoUiD2Oon4j7dfVQEJL14+AnbukK+iC55/FyNMu7o8cHuiLp0sfE4
         nfo+xFKx7lkrKRlZHbLR14Eg96+bZFexzYageFLWrb82DetNBgDLHPA34kFBmihOKAAG
         YWk84CMNb0bSKH+YwvQwJlCI3VVyDDY4V/UOa54uUhZrhvZjnCRKtti6zFeMNyGzTLn0
         2DE6nhf8AmdjQgZFcylCvo9ELRc43YUnwesDS8x9b0hBJG4tFUw6IbvCsKCSRW1PZd5o
         6d8w==
X-Received: by 10.182.39.161 with SMTP id q1mr2376870obk.54.1382113499738;
        Fri, 18 Oct 2013 09:24:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm4929524obb.0.2013.10.18.09.24.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2013 09:24:58 -0700 (PDT)
In-Reply-To: <20131018153009.GA23704@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236358>

Theodore Ts'o wrote:
> On Fri, Oct 18, 2013 at 06:41:41AM -0500, Felipe Contreras wrote:
> > > And I hazard to guess that the vast majority agree with Junio on this (based,
> > > again, on email evidence). Not with you.
> > 
> > That is irrelevant, and a fallacy. The vast majority of people thought the
> > Earth was the center of the universe, and they were all wrong.
> > 
> > It's called ad populum fallacy, look it up. Wether the majority of Git
> > developers agree that there's something more than a disagreement is irrelevant,
> > their opinion doesn't change the truth.
> 
> Look, the problem is that you insist on being "right", even on matters which
> may be more about taste and preference than anything that can be proven
> mathematically.

I don't insist on being right, I have an opinion and I voice it, there is
nothing wrong with that. If the other side agrees there's a difference of
opinion, that's the end of the discussion.

I would say it's actually the other side that insists on being right, and
that's the problem; they don't agree it's a difference in opinion, from their
point of one side is right, and the other side is wrong, and that's what causes
their frustration.

Ask Junio if he thinks it's simply a matter of a difference in opinion. He
pretty much already said it's not.

> Worse, you insist on trying to convince people even when it might be better
> to just give up and decide that maybe something not's worth the effort to get
> the last word in.  This is how we get to centithreads.  If every time someone
> disagrees, you insist on replying,

This is how it goes:

 1) Side A
 2) Side B

 3) Side A
 4) Side B

 5) Side A
 6) Side B

At any point in time side B could stop replying, sure, but so could side A.

Why do you blame ME for replying, and not the other side, for replying to my
reply?

Presumably because right before reply 4), side A thought the discussion was
wortwhile, and something happened in 5) that changed their opinion, and now
side B becomes a problematic person. And since you are friends with side A, you
take their side.

> and then if people give up in disgust, you then try to use that as "proof"
> that you must be right,

Show me *one* instance when I have done so. I have never used silence as
evidence of anything.

> Sometimes a question is important enough that it's worth doing this.
> But I'd suggest to you that you should ask yourself whether you're
> doing it too often.
> 
> After all, this is open source.  If you are convinced that you are
> right, and everyone else in the community is wrong, it is within your
> power to fork the code base, and to prove us wrong by creating a
> better product.

Don't worry, that is *exactly* what I plan to do.

> The fallocate NO_HIDE_STALE flag is a good example of that; it's used
> in production on thousands and thousands of servers by Google and Tao
> Bao, but since there was strong opposition on the ext4 list, we've
> kept it as an out-of-tree patch.  Note what I did not do.  I did not
> force the patch in, even though it might be within my power as the
> maintainer; nor did I try to convince people over and OVER and OVER
> again about the rightness of my position, and turn it into a
> centithread.

My patches are not good just for me or my company, they are good for everyone.

Have you actually looked at any of them?

> > My claim is that all I did was disagree with Junio. You can invalidate that
> > claim easily by providing *a single* example where I did more than
> > disagree.
> 
> The problem is when you disagree with a number of people (not just
> Junio), and you are, in my opinion, overly persistent.

But that's not what Junio said. This is the second time you defend Junio by
assuming his position is exactly the opposite.

Junio doesn't think it's just a disagreement, Junio doesn't think I'm just
being persistent, Junio is saying I can't be worked with.

The interesting thing is that when Junio agrees with the change, he can work
with me, when I agree my change is not good, the same, but suddenly when I
don't agree, then I'm not good to work with. See the pattern?

> We can argue whether you've stepped over the line in terms of impugning
> people's motives or sanity, but that's not necessarily the most important
> issue.  People sometimes step over the line, and while that's unfortunate,
> it's when it becomes a persistent pattern, and it happens frequently enough,
> that it becomes a real problem.

Have I ever impugned people's motives or sanity? Please, show me where I did that.

> Alternatively, if you are right that Junio is mad,

I didn't say Junio is mad, I said he got mad.

:  carried away by intense anger :  furious <mad about the delay>

http://www.merriam-webster.com/dictionary/mad

> and he's being capriciously insulting, then I'm sure that when you establish
> your own fork, lots of developers will come flocking to your flag.  If they
> do not, then perhaps you might want to take that as some objective evidence
> that the community is perhaps, more willing to work with him, then they are
> to work with you.

If you know anything about rationality you know that correlation doesn't prove
causation. So no, it would not be objective evidence.

-- 
Felipe Contreras
