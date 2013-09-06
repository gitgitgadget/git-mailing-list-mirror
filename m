From: Ping Yin <pkufranky@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Fri, 6 Sep 2013 23:45:44 +0800
Message-ID: <CACSwcnR+rHVDVHu8rwATU+VbGE-9zP=xB8Y-udPGoP6KvhprCA@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<CABjHNoR637ecLnnLwhj59ddnhy8Lcyk+2YzAqN=nxWN7-BkivA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: William Swanson <swansontec@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 17:45:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHyEM-0003iS-3M
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 17:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541Ab3IFPpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 11:45:46 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:53939 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab3IFPpq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 11:45:46 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so3060975lbh.28
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y+5xXzLOAw3tmtEQMM2A3JQDJDCUF91jRQJYwD+wNJc=;
        b=j066bCL2ZRm5WLRvh4Liih4PX98kQcOjfmfK8RQxH/+WOV/8q8gW/ldCD09ZLbYh1J
         o08bkQAm/COsiYAUrGVzqUYdEXhLMcISMawiIo4eOuji9sh30CHxHgtTs/7tdjZcfKty
         7Qbqdhq2kfW5vSM13Ija9p0urMCA9qFPhSHXlJVn7Hqb3nWTXnqG+BGLpp2fvuSZRcrj
         fg5j420n3tSRpS3OdeN4PPJG11K7HSvetQ5G2IayTFeFiCu2kdzGLXuVjDhlCiRdEDnA
         gv9KVbJMazNc8X0mR4abXf5GfOzNysVzunhRnU1HAZ0+bpVtZnn6wtewMgsBE45oN3M2
         8mZg==
X-Received: by 10.152.5.162 with SMTP id t2mr2727559lat.1.1378482344560; Fri,
 06 Sep 2013 08:45:44 -0700 (PDT)
Received: by 10.152.4.169 with HTTP; Fri, 6 Sep 2013 08:45:44 -0700 (PDT)
In-Reply-To: <CABjHNoR637ecLnnLwhj59ddnhy8Lcyk+2YzAqN=nxWN7-BkivA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234052>

On Wed, Sep 4, 2013 at 2:08 PM, William Swanson <swansontec@gmail.com> wrote:
> On Thu, Aug 29, 2013 at 11:01 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> It has been discussed many times in the past that 'index' is not an
>> appropriate description for what the high-level user does with it, and
>> it has been agreed that 'staging area' is the best term.
>
> I realize Git is not a democracy, but if the vote of a humble user
> counts for anything, I agree that "index" is a terrible name.

+1 for staging area

>
> I was very excited when Felipe first started this thread, since I
> thought Git might finally fix one of it's biggest long-standing
> usability problems.

the same feeling.
