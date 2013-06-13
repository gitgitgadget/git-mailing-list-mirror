From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Thu, 13 Jun 2013 11:19:01 +0100
Message-ID: <20130613101856.GA11034@workstation.dev.smoothwall.net>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 12:18:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un4bx-0007K0-IA
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 12:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572Ab3FMKS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 06:18:29 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:48667 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758514Ab3FMKS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 06:18:28 -0400
Received: by mail-wi0-f173.google.com with SMTP id hq4so1389965wib.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lxGQvE4+Fkv7eVm7o49O9MF2+a8Pt1wYKbaa7el7ugk=;
        b=XGQOoL0JCINdvS44YCb2upCVb+NfBRwdgQuB1M5vkDuDyzHRD3DLxMPpGJKXt2A7ba
         Lb+JiUvR3tLMg74kIPgQimcFYsga7NYGAJ5T9bOmt9Oo4Ia+/zf+Q9yROrgnr4vVY1+x
         PVrra8f1fdWROrDX6u28Qa/9aj2TKo3e1bBhEDSewKLzlmPwlL0gby774/Q9zlkbZR/0
         +ymByNMQeJMFBMmjNKZpg9ktBM/x8LXPj6gJVu4yqw4+wP9cwXqxWcS+5SComr1ip/QX
         1eTu19En8aJFGH6h41SSt1byL/RK8uQRiW3QtG8EJf9XFuPGhwoywB4UBPO3h8GY5b7x
         2nNg==
X-Received: by 10.194.90.244 with SMTP id bz20mr77020wjb.69.1371118707448;
        Thu, 13 Jun 2013 03:18:27 -0700 (PDT)
Received: from workstation.dev.smoothwall.net (82-69-211-1.dsl.in-addr.zen.co.uk. [82.69.211.1])
        by mx.google.com with ESMTPSA id fs8sm3970692wib.0.2013.06.13.03.18.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 03:18:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227716>

Hello,

On Mon, Jun 10, 2013 at 06:58:47PM +0530, Ramkumar Ramachandra wrote:
> I've tried to write down a bare minimum, without restating the obvious.

[...]

I often come across so-called "community guidelines" in other
projects---some of which adhere to them quite strictly, and others simply
document something for the curious.  But usually the reason for their
existence in the first place are tell-tale signs of trying to fix a problem
at the wrong end, and I believe this is what is about to happen if a
document such as this ever becomes official.

There's no disputing the fact that over the last few weeks, FC's behaviour
has been called in to question.  He's managed to rub a lot of core people up
the wrong way, and in doing so has deliberately side-stepped that problem by
doing the one thing which puts anyone trying to raise that point muted; by
assuming that he's right.

It's a point on which one is never going to win, because no matter what one
says, it'll just get twisted round in such a way that one then ends up
questioning their own words, and their own conduct, and that's bad, because
there never was anything wrong with them to begin with.

So when you realise this point, it becomes almost impossible to proceed
further with any kind of discussion, because even the technical points of
discussion then end up being lost in a tirade of needless side-stepping
discussion.  It's a bullying tactic on the part of FC which means he'll do
any, and everything, to get his own way.

So I say to all those seasoned reviewers out there on this list not to put
up with it.

There comes a point, regardless of how useful someone's contribution may be,
that if the barrier to entry is so high that any kind of criticism or
comment made against code comes with a massive chance of having to defend
yourself against innocence on the part of the reviewer, that those
contributions should be shelved.  I've seen also another yardstick used to
defend FC's behaviour, and that is one of "commits within the last three
months".  That count is completely meaningless, since the review process is
always going to be the same.

So these guidelines gain the community nothing, and only serve to punish
those who are already following them, without them being written down,
because the root-cause of the problem is still here, and isn't going to go
away, no matter how much referring to these guidelines might help.

That is why I think this is the wrong thing to do.

-- Thomas Adam
