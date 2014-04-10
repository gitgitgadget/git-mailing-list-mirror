From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Our official home page and logo for the Git project
Date: Thu, 10 Apr 2014 10:24:24 +1000
Message-ID: <CAH5451kNoXobbh3-WBkewvKvNeFkV0P14Z55=qDN+Ak2WGkHSA@mail.gmail.com>
References: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com> <534578b2e22e2_af197d3081@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 02:25:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WY2np-0003Wh-7I
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 02:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934420AbaDJAZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 20:25:07 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:33608 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933204AbaDJAZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 20:25:05 -0400
Received: by mail-ve0-f182.google.com with SMTP id jw12so2862844veb.27
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 17:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bg5xxG5pEEcTrqENuw4kpRJd4RYOHp7diwO9FyEUvvM=;
        b=QrGyBtSO7iGpX9IiArrpkRjHs4KquG2hI9shOyjB7DJ4ZrmuFwp7JQ63TwTAWDRw23
         0Ft3MhOGJ13UOkbeZm0mzsnKZhIwtWhvH3wp6KL7Y46HYNV+8CiBYZ2jqx9g4WwQqTB4
         XuY1+Y1eTRtFMDAv6WJQKd5IX2UsXqEFhg4QXDNS9GB30w5i03fsC6yk24jj/256QSF1
         N/izdkX18ahECA7t3za3dFE0VOhtwtJuWZXzRVrbLDigI1CYuaH3x8ejoXSnlFJHMozE
         ApdGSnwuj/oHOMYNn9+cO8MMw2JJWav/Y4QEr/6ySPB9MLwOx9R+cRcTaQupBbq28OIc
         4LVw==
X-Received: by 10.220.4.132 with SMTP id 4mr11586401vcr.9.1397089504424; Wed,
 09 Apr 2014 17:25:04 -0700 (PDT)
Received: by 10.221.8.133 with HTTP; Wed, 9 Apr 2014 17:24:24 -0700 (PDT)
In-Reply-To: <534578b2e22e2_af197d3081@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246005>

On 10 April 2014 02:43, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Junio C Hamano wrote:
> >  - To officially adopt the logo that appears on the "project
> >    home page" as our "project logo".
>
> I have made my objections to that logo before, but here it goes again: bright
> red is a horrible color for a logo, as it only looks good in limited
> situations. I propose you use the logo I chose for git-fc[1] which has a better
> color, and instead of showing commits going down, they go up.

It's normal for an organisation to have a collection of logos to
choose from, with one 'official' version. For example, a black and
white version is useful for print. Similarly, it's useful to have a
couple of different contrast level/colours that can be used in the
appropriate situations.

I think it is fair to say that the red version is the one people
recognise as 'git' and so should be kept as the official version.
There is nothing wrong with having alternates that have been approved
for various situations.

I recommend creating a git repository called git-resources,
git-marketing, or git-assets, to contain the various approved logos.
If there is not another location, or a more appropriate one,
https://github.com/git would be a good place to put this.

Regards,

Andrew Ardill

(I'm always concerned about making useless contributions to
conversations like this, but I think having a specific location for
resources like the logo will be very valuable).
