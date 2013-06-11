From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 10:52:53 -0500
Message-ID: <CAMP44s01BF6cGc6DM2JzifzyeLnd+q541rxx=BuaiTUBQM8ffA@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
	<CALkWK0nNn8Rcu4JpV4r+0ct+_cuW3aUHXKV4bcB-Hn6Xg8Y+bA@mail.gmail.com>
	<87li6g969j.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s2fZemrqrBQGwFduE3dYs6S_dBO1fwpbfyDPn+jovze-Q@mail.gmail.com>
	<87obbc4pv7.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 11 17:53:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmQsW-0002So-05
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 17:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab3FKPwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 11:52:55 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:47924 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab3FKPwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 11:52:54 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so3405378lbi.6
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2T1h/UJ6+Bw+Kl4raxL6cak0N2OZqgUL/8H47Anc00A=;
        b=SZ+Em6QahdTB81yuOFZMoFlM8edE/nDftIsPTma6TzRNBZc24vKOu6Ci956I9x1A2i
         qToXnIz5UHm4d+DBfXWFHflNd+OX0N509Hp6HhWkMUDOYl9qtNyKVxBLRf99c+IIzARL
         Qt4pFIaFf+P0FP3qn+ZOKFg4P1gYu9JsVWL3HtRjOuaLG37OQ/za1NU8Ia3D6jKIixM3
         9cegqaBo3Fg3AaU84uV0DGwYtf0jfs3XAlAcpswCLl9PcggC0Gj6tWmjjRTPHUaGc9HK
         4khP8ItPDEDUBn+U2PFGKtIRoFCi/gLosMoF9sbdi4BN/0xKKumX6BW+bdmdnIN56xN+
         UpOA==
X-Received: by 10.112.157.226 with SMTP id wp2mr8987840lbb.65.1370965973117;
 Tue, 11 Jun 2013 08:52:53 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 08:52:53 -0700 (PDT)
In-Reply-To: <87obbc4pv7.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227456>

On Tue, Jun 11, 2013 at 10:41 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Jun 11, 2013 at 7:33 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>
>>> My approach -- and in my perception also that preferred by most of the
>>> regulars who have spoken in this whole mess -- is that since there is a
>>> fire hazard, it would be more effective firefighting to just remove the
>>> hazard, thus preventing future fires.
>>
>> You would make an excellent evil dictator.
>>
>> A benevolent dictator like Linus Torvalds knows better, in the LKML
>> "fire hazards" are not removed, they are ignored before any flames go
>> up. This achieves the best of both worlds; if the person is truly
>> vicious, nothing happens, but if there's something to it, a person
>> that doesn't offend so easily might have a fruitful discussion, while
>> the rest ignore the thread.
>>
>> In a flamewar everyone is guilty. Apparently you never learned that
>> "but he started it!" is not a defense worthy of an adult, hell, even
>> most children know that.
>
> [Yes, I should let this thread die, but you are offering me too good a
> chance to pass up.]
>
> It's funny that you would mention Linus, considering there's at least
> one instance on record where he broke almost every rule that Ram
> attempted to set out in the thread starter, calling you among other
> things a "fucking moron" and telling you to "go away".
>
>   https://lkml.org/lkml/2012/4/12/434

Yet, this "fire hazzard" was not removed, nor was there any threat of
doing so at any point in the discussion.

> In case our readers wonder why the flame war suddenly died out at a
> depth of about 19 replies, fear not, for the story continued:
>
>   https://plus.google.com/108736516888538655285/posts/7QSVy8taWgC

You sure like your ad hominem arguments. Perhaps it would be wise to
get the timeline right. The Google+ discussion you are pointing to
happened *before* the thread ended, even Linus replied after that:

http://article.gmane.org/gmane.linux.drivers.ath9k.devel/8675

> And before you try to shoot that down, please make sure your argument
> also applies to the recurring situation of your repeatedly ignoring
> SubmittingPatches as far as commit messages go against explicit requests
> to stop that.

There's nothing to shoot down, you are not making any argument. You
are doing nothing but throwing personal attacks.

If what you are suggesting is that we should do what they did in the
LKML; they did *exactly* what I'm suggesting you should do; *ignore*
the people that you think are vicious.

Is that what you are suggesting?

-- 
Felipe Contreras
