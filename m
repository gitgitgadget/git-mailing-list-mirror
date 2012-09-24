From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Mon, 24 Sep 2012 16:31:40 +0200
Message-ID: <CANQwDwfqv46WaPnh++ts7DYrg2R=yo7dyh2L7y+8astad9WWmA@mail.gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <201109031738.11678.jnareb@gmail.com>
 <CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
 <201109141939.14070.jnareb@gmail.com> <CAMP44s31xx5qfF4-f3kGsa1uEe7TMVmqSDvB9zL=prR12xwM6g@mail.gmail.com>
 <CANQwDwfVM+besf2if-z6UT6K1QYfj7A7jXsEgfyfxJ1Ww9oBdA@mail.gmail.com> <50605EDF.4090005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:32:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG9hl-0006Da-KG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab2IXOcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:32:03 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48525 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab2IXOcB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 10:32:01 -0400
Received: by oago6 with SMTP id o6so5445442oag.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=owazeb2X2g9Zk4dIdxKy/JhiAV058U/xxPixMbjxFZI=;
        b=DATsi/JOkn7/aXQm46A4RN/GYNzn4Q1wTn90bv32Acsb1L4N2MKNZDiO5lQ/eybNo6
         sSRT1siTuaIeCAJloNPMV7d9ukD+X1c3R7EwMPF1Vt12EBPubiCJk+xNhUjfee36AmER
         euRJUEAvkE0GCw+QABzZCaksrFtIIshEGdOWCfLTwbcuhwjHbG1FGQQGY9vil3inMb6z
         +cQJU/p968UV7rwtSLCQDxukcH6rlSudS3Zw7YDJSF1lyuD+qY7p41NGyCcT7Vx09iGc
         s3hcKzOUQAOFs2SAtXI+BXSq0e59QTIfMqwq3X1H1rFbaW1qdgCPth4Rje1fZiMMVILA
         9EWw==
Received: by 10.60.8.71 with SMTP id p7mr10168680oea.56.1348497121151; Mon, 24
 Sep 2012 07:32:01 -0700 (PDT)
Received: by 10.76.163.98 with HTTP; Mon, 24 Sep 2012 07:31:40 -0700 (PDT)
In-Reply-To: <50605EDF.4090005@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206275>

On Mon, Sep 24, 2012 at 3:23 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
[...]
> Other version control systems:
> I think the list needs to be sorted alphabetically, it's really long.

I have split this list in two: other centralized VCS and other distributed
VCS; both have "other" field.

> (You could also reduce and offer a text field "other.)

I tried to include all important VCS.  There is always problem with
analyzing responses from "other" field...

> Resources:
> I wouldn't put git-scm.com and the pro-git book into the same item.
> git-scm.com was supposed to be "the" git community website (and also
> "the" reference on git), and the fact that it looks like a pro-git book
> sales platform is a different matter.

Good catch. Originally there was "Git Community Book" on Git Homepage,
and "Pro Git" had its own homepage; now they are folded together.

I have slightly rewritten the description to account for this.

>
> An interesting question would be: "What is the first source you consider
> Git?", or even: "What is the Git homepage?"... Really, getting input on
> what "the Git homepage" should be like would be nice, but not comparable
> to previous surveys.

As you can see this year survey is [almost] bereft of essay free-form
questions.  It is because of difficulties and time needed to analyze such
responses. So I don't think such question will be included this year.

I think it is better discussion for git mailing list or something...

-- 
Jakub Narebski
