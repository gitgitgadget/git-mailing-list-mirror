From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Our official home page and logo for the Git project
Date: Fri, 11 Apr 2014 15:26:37 -0500
Message-ID: <53484ffd4d687_8291657308d3@nysa.notmuch>
References: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
 <534578b2e22e2_af197d3081@nysa.notmuch>
 <CAH5451kNoXobbh3-WBkewvKvNeFkV0P14Z55=qDN+Ak2WGkHSA@mail.gmail.com>
 <20140411114017.GC28858@sigill.intra.peff.net>
 <9D09EA38-1956-467F-88CF-9EA6F12F1CA0@quendi.de>
 <20140411132935.GA5871@nysa.casa.local>
 <D372C563-C59D-47A6-91A3-D2C6BB2164B1@quendi.de>
 <20140411152147.GA12161@nysa.casa.local>
 <40FDE1FF-780F-46E1-A5AA-57D53D6D1C87@quendi.de>
 <53483ac0be5d5_937adb308e2@nysa.notmuch>
 <8BCDA559-89F0-4FD1-AA76-94CC67CB32C4@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 22:36:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYiBn-0001KO-1H
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 22:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbaDKUgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 16:36:38 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33594 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbaDKUgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 16:36:37 -0400
Received: by mail-ob0-f181.google.com with SMTP id wp4so6632145obc.40
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=D/+fvBxrslRHiPpvVr0xi+7Ddz8r3dEFfAjNbaDO0KU=;
        b=yJeBzomIxV2M/Z9//KJI+4qJd1IqG2v44T6Iyy2hnvf5eD78rLFBFBwgK5H6hmnqMr
         lvLNvUl8xBNFdwJiWglHYn3EY6MQ/ZWh+MkfKtPx53VbX5XNZaSVCrX/hmmnB+aqy1oS
         RIrfhsgYq9WGFQzR0267Z88qTbcwir7i3/a7I84DgUEZdKh8UEKkVf0bthDwevKSrJUu
         tBSidKK47OqNCCiehYkTQol2j41pDTWXnuV3rpdNPF2lVD8WUFjyFz3yWVYyDvIsMz11
         oN0z4YUkcGCUKtMiG03dSQchUCIsixZZ/eecguMWbV7txBvRtRO6X/y+xQJEKhHw87eS
         1l2A==
X-Received: by 10.60.17.132 with SMTP id o4mr10234898oed.34.1397248597063;
        Fri, 11 Apr 2014 13:36:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id la3sm14063015obb.19.2014.04.11.13.36.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 13:36:36 -0700 (PDT)
In-Reply-To: <8BCDA559-89F0-4FD1-AA76-94CC67CB32C4@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246142>

Max Horn wrote:
> On 11.04.2014, at 20:56, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > Max Horn wrote:
> >> Come back when you have facts, as opposed to the illusion that you are the
> >> spokesperson of the (apparently silent) majority of Git users.
> > 
> > Facts:
> > 
> > 1) A hunk that removed (-) is represented in red [1]
> > 2) A hunk that added (+) is represented in green [1]
> > 3) A file that is removed is represented in red [2]
> > 4) A file that is added or modified is represented in green [2]
> > 5) A test that fails is represented in red [3]
> > 6) A test that succeeds is represented in green [3]
> > 7) The current Git logo (accordo to some people) has "-" in red, "+" in green [4]
> 
> I do not dispute any of that.
> 
> > Given these facts, it's reasonable to assume that to the majority of Git users
> > red is old and bad, green is new and good.
> 
> This is where you are making the hasty generalization.

And you prove again you don't know what that means.

> Your facts do not suffice to prove this conclusion. 

That would be an invalid argument, not a hasty generalization.

> And even if the conclusion is true (which is possible despite your flawed
> argument, although I doubt it), then you are making another implicit
> assumption: Namely that people will automatically transfer the red/green
> principle from diffs and test results to logos. 

It is not only diffs, in general in the tech industry red means failure, green
means success. I can show you many many more examples if you need them.

Then you somehow think that when people see the Git logo they are not going to
asociate they countless hours they've been actually using Git, and seeing red
as bad, as if somehow the logo has nothing to do with the program. If that was
the case we might as well choose a cow for a logo, because it doesn't really
matter.

If you knew anything about logos you would know that the target audience does
matter, and the organization's use of certain colors is important as well.
Google for "how to design a logo" and you will find many references [1][2].

But didn't you say the colour didn't matter? If you really think that, then you
should agree at the very least that green is as good as red. And if you don't
care which colour is best, why are you arguing?

[1] http://www.creativebloq.com/graphic-design/pro-guide-logo-design-21221
[2] http://www.wikihow.com/Design-a-Logo

-- 
Felipe Contreras
