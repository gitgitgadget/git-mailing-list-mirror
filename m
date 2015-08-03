From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft of Git Rev News edition 6
Date: Mon, 03 Aug 2015 13:07:23 -0700
Message-ID: <xmqqfv4087b8.fsf@gitster.dls.corp.google.com>
References: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nicola Paolucci <nick@durdn.com>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 22:07:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMM1C-0007wE-6U
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 22:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbbHCUH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 16:07:26 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36299 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469AbbHCUHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 16:07:25 -0400
Received: by pdco4 with SMTP id o4so12385714pdc.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 13:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mUvLhvif2ewNLyI0wTs89R9QF9IO11sJ+nBIJo8CnDg=;
        b=o60dSh8JoU4LkyJCtVtCMDTWbiVWT9OZ18BwOFwqdggMVmwIGCT0UUbw9BrgYQ5wtq
         BA5rRyULn+mo30pQnnb0sF9/jOlIwACXl4tOoq94s0FJlswZR6+Juc2o9MGCTm96FSXi
         P+iw/debdzV0dR/EhcrdV35n/2sj2z8fDfPsMySrzRRGKO3XpbWtp3cy5c/C1ALscymR
         AF/xaEmjAY4bH47Un+lMI/sdJwNBw+suMMnoMT1J9KuqUUjZPhL3Se1313DbElhhltMT
         skclYDvSRrDyQlNuzdShpW2mQrpd07Of8StkHjKS+v2dnh1Two1QSvnhVU/RmiUT+uq+
         s0Pg==
X-Received: by 10.70.1.102 with SMTP id 6mr38816509pdl.32.1438632444730;
        Mon, 03 Aug 2015 13:07:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id i5sm18509854pat.42.2015.08.03.13.07.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 13:07:24 -0700 (PDT)
In-Reply-To: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
	(Thomas Ferris Nicolaisen's message of "Mon, 3 Aug 2015 00:52:13
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275193>

Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:

> A draft of Git Rev News edition 6 is available here:
>
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-6.md
>
> Everyone is welcome to contribute in any section, either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
> https://github.com/git/git.github.io/issues/89
>
> You can also reply to this email.
>
> Me and Nicola are planning to ship this edition on Wednesday 5th of
> August (as Christian C. is away on vacation these days).

Thanks; it seems that the review section is rather thin.  No new and
interesting changes worth reviewing in the entire month of July?
