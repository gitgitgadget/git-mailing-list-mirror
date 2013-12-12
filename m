From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 17:51:13 -0500
Message-ID: <CACPiFCJDP6OVju2xzm2NWR5gc=bZDeNmXsD_MFH2mgHQru_u6Q@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li> <20131212182932.GB16960@thyrsus.com>
 <CACPiFCJ22xiedXAoQktMLd=gASgD0NS24Pya9TvCo9aQP5JaBQ@mail.gmail.com>
 <20131212193918.GA17529@thyrsus.com> <CACPiFCLXeK9DH=f80ReSmYHJ7zjOn-D2zvs3WmdiV-k=wBGgjA@mail.gmail.com>
 <20131212205819.GA18166@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 23:51:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrF6o-0003aS-3e
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 23:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab3LLWvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 17:51:36 -0500
Received: from mail-ve0-f174.google.com ([209.85.128.174]:33933 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3LLWvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 17:51:35 -0500
Received: by mail-ve0-f174.google.com with SMTP id pa12so840258veb.33
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 14:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4XrM4u0FuUgX1//paDYY2ZpvhZ5n+LnzlFkR6gN2DhI=;
        b=fBebxKTuLJWZzP12OK7TYIgJOsI+GU9F0NiUKl/SZ+aDT2zbtvqem23qegk2tteEgW
         bEgONdh9OghA4nLc2vzyIA4aKiaDzeIC/L562uTlbZWxpT0qF3ysKfTSQSDOt7b37v+L
         Xys1Xvt1NzbGTs+T3Y55DbN0SOwUZGJbQd5siQewYuiyXof28dw1aQgq+vm8DU1wzWY6
         XztPyFj4C1xwZsyjWAzVfs5Z/IH5yL1c68A4RK+CKzFCkWXXJRA7AQG608Gby9/vUyjE
         +Luijx05qmN1D/kKsdA6QyMA1zpHOfgZxOcUbjj5SBv5MnQSFdoSFW8V8ehS+CdyEU86
         Yirw==
X-Received: by 10.220.244.132 with SMTP id lq4mr1029186vcb.31.1386888694630;
 Thu, 12 Dec 2013 14:51:34 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 12 Dec 2013 14:51:13 -0800 (PST)
In-Reply-To: <20131212205819.GA18166@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239248>

On Thu, Dec 12, 2013 at 3:58 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
>>  - regardless of commit ids, do you synthesize an artificial commit?
>> How do you define parenthood for that artificial commit?
>
> Because tagging is never used to deduce changesets, the case does not arise.

So if a branch has a nonsensical branching point, or a tag is
nonsensical, is it ignored and not imported?

curious,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
