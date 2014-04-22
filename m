From: Brian Gesiak <modocache@gmail.com>
Subject: Re: Git in GSoC 2014
Date: Tue, 22 Apr 2014 11:18:46 +0900
Message-ID: <CAN7MxmX4GqWFH5WnZbS2ZdHP1QpQAUmpadRp5euHT+wU2we7BA@mail.gmail.com>
References: <20140225154158.GA9038@sigill.intra.peff.net>
	<530CCFB0.5050406@alum.mit.edu>
	<20140226102350.GB25711@sigill.intra.peff.net>
	<530DC4D1.4060301@alum.mit.edu>
	<xmqq8usx4pvh.fsf@gitster.dls.corp.google.com>
	<530EEAA2.3030306@alum.mit.edu>
	<xmqqlhwwz7m7.fsf@gitster.dls.corp.google.com>
	<530F9F59.4030307@alum.mit.edu>
	<xmqqfvn4xpnh.fsf@gitster.dls.corp.google.com>
	<CAH5451mXb2z0oWv0jQuBCwE-x=0Bx0VPXJHSns7T1FsBTUQKOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 04:19:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcQJN-0002tc-RY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 04:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbaDVCTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 22:19:35 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:43423 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbaDVCSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 22:18:47 -0400
Received: by mail-ie0-f170.google.com with SMTP id rd18so4702279iec.29
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 19:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EIFJiUxIYYs7DGw2nK8ZH4OuHW0K7HaDxYmkwaH82aE=;
        b=xPt99bFfdvCsDWRFUTiar9w8qTrlyGL0kS1ruF0N7UvZs0ZswnHwX32+vop4IpAwqs
         zp2OizsWLI9sOGucg91dhctCpcLGv07eWGjcOhnJDVpsM4onir+imTfXM82+trFYSQav
         bz4YQQ6VR+cFM14iOqf+vQI+16ykKNQo/aN5VZGbRQYY3QtT09sWaKGIyDkWAiQjoTr9
         OlfILvBCx/RMLzvLMkpI2bd860Z1UP930w9gcs5HjRMCY7ilSNFyBxWSGHsG47zjOUtE
         RU2tIlnMZHQG57HP8qH65jLHNEkOH+f2UlGKt2fLmY/cSROfYDVjAXEsJLIWtb6wJXvV
         kIMw==
X-Received: by 10.50.134.164 with SMTP id pl4mr26127254igb.21.1398133126233;
 Mon, 21 Apr 2014 19:18:46 -0700 (PDT)
Received: by 10.64.55.165 with HTTP; Mon, 21 Apr 2014 19:18:46 -0700 (PDT)
In-Reply-To: <CAH5451mXb2z0oWv0jQuBCwE-x=0Bx0VPXJHSns7T1FsBTUQKOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246686>

Thank you!

I'm very excited to be participating in this year's GSoC. Google
recommends that students use the next few weeks to get to know their
mentors, read documentation, and get up to speed to begin working on
their projects. Students have also received instructions on submitting
tax forms and other paperwork.

Aside from filing all the requisite paperwork, I plan on reading
through the extensive set of patches on lock files Michael Haggerty
submitted after my initial proposal. I also plan on consulting with my
mentor, Jeff King, on some good first steps.

By the way, my name is Brian Gesiak. I'm a research student at the
University of Tokyo, specializing in parallel and distributed
computing. If you have any questions regarding my project, "Unify and
Refactor Temporary File Handling", please feel free to contact me via
this mailing list, or privately via email. I'm also on GitHub[1] and
Twitter[2].

[1] https://github.com/modocache
[2] https://twitter.com/modocache

- Brian Gesiak

On Tue, Apr 22, 2014 at 10:06 AM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> Congrats everyone who was successful in being picked for this year's GSoC.
>
> Fabian with "Line options for git rebase --interactive" [0]
> Brian Gesiak with "Unify and Refactor Temporary File Handling" [1]
> Tanay Abhra with "Git configuration API improvements" [2]
>
> I look forward to seeing how you go!
>
> [0] https://www.google-melange.com/gsoc/project/details/google/gsoc2014/bafain/5750085036015616
> [1] https://www.google-melange.com/gsoc/project/details/google/gsoc2014/modocache/5639274879778816
> [2] https://www.google-melange.com/gsoc/project/details/google/gsoc2014/tanayabh/5766466041282560
>
> Regards,
>
> Andrew Ardill
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
