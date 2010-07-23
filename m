From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 15:01:52 -0400
Message-ID: <4C49E720.20207@gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> <4C49B0E9.1090300@web.de> <4C49BDB7.3080805@gmail.com> <4C49CD49.4010101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 23 21:02:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcNVa-0006wd-5e
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 21:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457Ab0GWTCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 15:02:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39030 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab0GWTCB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 15:02:01 -0400
Received: by iwn7 with SMTP id 7so436591iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=/8oUL8Ugmk4vmMMfL3SDdENxA4WdziYiq0hNlBgXtGU=;
        b=Y0eLXQ/WkxKIt/wfN2/siztl/Wq8cms0IdQRnmDJXIQyUniDgQ+VYa1aow/ExPYHKb
         Lu59sYzsC/NhR68F8tPkYcmtFwiXq2k2RrNhUcGUTOExJ33vzOnKd7lDzW20fjSX6P9B
         +QPy7ycA/vjfyQxP8HiXco0WUNLwKTLZj24JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bz9ql8xDCm+uUjGHz0jGgX/2QhxOqOApZaeLL5Ot2bEPtsZyYUiPXnmrWYxa9rtzco
         FT469QXe3dMcPhZnKLazt9/d32FNi0f14x1X6oSwGny1ooMLs5uHh42pFgUGp5GsJRyb
         eP0N4Gkcj3SyBqH+mFuT/ivOjkEiew/40uzAQ=
Received: by 10.231.200.146 with SMTP id ew18mr3782791ibb.117.1279911716937;
        Fri, 23 Jul 2010 12:01:56 -0700 (PDT)
Received: from [192.168.1.102] (76-10-182-75.dsl.teksavvy.com [76.10.182.75])
        by mx.google.com with ESMTPS id h8sm467788ibk.15.2010.07.23.12.01.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 12:01:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <4C49CD49.4010101@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151566>

On 10-07-23 01:11 PM, Jens Lehmann wrote:
> Am 23.07.2010 18:05, schrieb Bryan Larsen:
>> On 10-07-23 11:10 AM, Jens Lehmann wrote:
>>> That is just one example. Another one is code shared between
>>> different repos (think: libraries) where you want to make sure that
>>> a bugfix in the library made in project A will make it to the shared
>>> code repo and thus doesn't have to be fixed again by projects B to X.
>>> This was one of the reasons we preferred submodules over subtrees
>>> in our evaluation, because there is no incentive to push fixes inside
>>> the subtree back to its own repo like there is when using submodules.
>>
>> But you stated above that each project has its own fork of the library.   So there's no special incentive to push changes from the fork back to its master repo.
>
> When you are not working on your own, it is preferable to be able to
> get changes upstream into a submodules repo to share them.
> So if you can do that (either via push or patches sent by email or
> whatever), then use it's URL directly (and then you have the incentive
> that fixes get pushed, which is nice).
> Or you can't, then use a fork reachable by the people you work with
> (then you still can see all fixes made by your group in the forked
> repo and can decide to push them upstream). Then pushing fixes back
> to the original repo is a matter of courtesy, as it is with every
> other work flow I know.
> And I think that is just the same thing we all do with plain git
> repos when working with others: If you can push, you use it directly
> to clone from, if you can't, you fork it.

So basically you're saying: sometimes you can use a non-forked 
repository, which has a whole bunch of disadvantages, but has the minor 
advantage that you're "forced" to push your changes upstream.

Which I see as a disadvantage because that means you're pushing untested 
changes.

Or else you use a forked repo, which is basically the same as using 
git-subtree, except for a lot of additional admin hassle.

>
>
>> In my experience, it's possible to make it usable if and only if:
>>
>> 1.  you have a small team
>> 2.  all of whom are very comfortable with git
>> 3.  changes inside submodules are either infrequent or only happen in a single direction
>> 4.  the project is not public/open source
>>
>> I think #4 is the killer reason why submodules don't work.  It works fine if the submodule is fairly independent, but if you have a patch to the submodule that was created for and in the context of the superproject, things get really annoying really quickly.
>
> What is the problem with the "forked repo" solution for #4?
>

Please tell me how I can set up a public project on github where project 
A contains module X, so that Joe Average User can clone A, make a change 
in the module X and send a simple pull request to get that change into 
A.   The change is one that's inappropriate to push upstream to X 
without additional work, but is appropriate for A at this point in time. 
  Joe's a beginning git user.

That's actually a simple use case compared to others I've run into.

Bryan
