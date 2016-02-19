From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 10:23:56 +0100
Message-ID: <0E364888-DD95-4B47-9679-3CB586FC7E8C@gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank> <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com> <vpqh9h7f9kz.fsf@anie.imag.fr> <1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com> <CAGZ79kbGyCTdq4P02fNb7tEuvkvqcZviWJp40Ob1ed6=JCh9Xg@mail.gmail.com> <xmqq7fi1hlw6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 10:25:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWhJD-0002Xr-A8
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 10:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbcBSJZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 04:25:00 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37698 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161117AbcBSJYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 04:24:03 -0500
Received: by mail-wm0-f41.google.com with SMTP id g62so62099028wme.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 01:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M9Bwcv+AuY4sNE4aT4xBDzJevy+ARTZHhxlcDK2/08k=;
        b=HfA/wDeT8FnnGB8vf3/Eftjiu0k/MMW6H7hTZpnVdfm3YMI1V4cBPSH2+2aFCD41Xa
         CWjHgDJl6PGG+YqmJ+TKvF4mR+L70KYEhv7DV+kM25FhFdBj7MHSLhdtI1GFoX+h2ENo
         spPXlpmvQd0IAjWv3w3of2pc8s49n9HydMpTVp934bkAFbwagDShk++OXDzob1dfMdgi
         yiEZiMFJ1GW58tBnN3wEzbHO4F+jjq/O0lYenVCFrlvSqFJDpSV2TlHtT1PvHZ/JH495
         tKVOQo7jU/gG010xbmdi3hY9Z9AuUqjQtmLHlgfmiI4ik0RyXgQedt1dW84J1FuTIhiI
         JAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=M9Bwcv+AuY4sNE4aT4xBDzJevy+ARTZHhxlcDK2/08k=;
        b=V84ujrfyrGwe64ts1ga7ZZFYPyxP3CQq5qfoOGpVImZSdig8CdLknFOtkTJF5IlTkA
         BSTAC9r/caHmGR/u13Q78SIM8tMUZKg3rrfPO3HaUfFG4tVq+bI4xRNnHMNw4RiFvD38
         9V5KfF8mvDhYyfoeuh4ndpSyDYFPMbXRts4c8GxUPz0C7G1vfYG1wF+v4h3pfQvQ2HTk
         LJS/woEuSmKrpUKbKRuXdxi/TOKwSSWqEQic3XWgVYqDiUg8KMd0HGihC08osjUPHEXU
         d+Lve9P4lS2qz7AnjooDukN94wEFx1sm3nhI45ThiSbYALiNCE9Xpksfdyj62EOCjlLi
         O2JA==
X-Gm-Message-State: AG10YOS05yrBe68gKaqLamXCVknsXEBr4pc04i33sVFODVaLNcUmErzgcch2ifeI96cFOQ==
X-Received: by 10.28.226.6 with SMTP id z6mr7611585wmg.44.1455873839804;
        Fri, 19 Feb 2016 01:23:59 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB455F.dip0.t-ipconnect.de. [93.219.69.95])
        by smtp.gmail.com with ESMTPSA id ei9sm10297042wjd.40.2016.02.19.01.23.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 01:23:58 -0800 (PST)
In-Reply-To: <xmqq7fi1hlw6.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286677>


On 18 Feb 2016, at 20:13, Junio C Hamano <gitster@pobox.com> wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
>> On Thu, Feb 18, 2016 at 12:41 AM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>>> Feel free to start writting an idea for
>>>> http://git.github.io/SoC-2016-Ideas/. It'd be nice to have a few more
>>>> ideas before Friday. We can polish them later if needed.
>>> 
>>> I published my ideas here:
>>> https://github.com/git/git.github.io/pull/125/files
>> 
>> I like the idea of a beginner mode, but on the other hand that looks
>> inflexible to me ;)
>> (What if I want to use rebase, but not reset --hard?)
> 
> That's simple.  You say "cd .. && rm -fr repo && git clone" and
> start from scratch ;-).
> 
> This whole "beginner should be limited to a 'safe' subset" is an
> unhealthy attitude.
> 
> Deciding what the 'safe' subset is must be done with a lot of
> thinking by people who intimately know what implications it has to
> ban each feature.  I do not think it would be a good fit for a
> project to give to a relatively new participant to the Git project.
> 
> For example, I think banning "worktree" feature from newbies may not
> be a bad idea, as you can work on a project without using "worktree"
> at all, and use of "worktree" would only subject you to bugs that do
> not exist when you do not use that feature.  The "shallow clone",
> "sparse checkout", and "untracked cache" fall into the same category
> for exactly the same reason.  The "submodule" feature might fall
> into the same category for the same reason, but that is not
> something you as a project participant can unilaterally decide, as
> the project you are working on may have already decided to use the
> feature, so it is harder to ban from the beginners.
> 
> But for the rest of really "core" part of Git, I do not think there
> is any such command that can be totally banned.
> 
> We have these "powerful" tools for a reason.  After making a mess
> experimenting with your working tree files, "reset --hard" is the
> best tool to go back to the known-good state, and robbing it from
> the users is not a sound approach to help them.  When "powerful"
> becomes "too powerful" is when a "powerful" tool is misused.  It is
> perhaps done by mistake or perhaps done by copying and pasting a
> solution from Interweb for a problem that does not match your
> situation without understanding what you are doing.
> 
> What is needed to help beginners is to make the powerful tool harder
> to misuse.  Of course, that would be a harder task, because you have
> to do a real thinking.
> 
> You do not have to do any thinking to say that "a blanket ban that
> hides these powerful tools behind the beginner mode" helps
> beginners, but I do not think it is solving what really matters.  At
> the same time, it just adds to the FUD, i.e. some commands are too
> powerful for their own good.

Thanks for your elaborate response. I think I got your point and I
tried to adjust my "beginner mode" proposal accordingly [1]. Here
is the relevant change:

If this mode is enabled then Git shall print a warning message before 
running a potentially destructive command. In addition to the warning 
Git shall print a command that would reverse the operation if possible. 
Most of the information to reverse an operation is already available 
via git reflog. However, the task here is to make this information more 
easily accessible to Git beginners.

--

Does this go into the direction of "making the powerful tool harder to
misuse"?

Thanks,
Lars
