From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Draft of Git Rev News edition 6
Date: Mon, 3 Aug 2015 23:43:18 +0200
Message-ID: <CAEcj5uU=iug=3C_XiGtWyVp=6Zi8qKHA6tjJ8am2-7j80BvHwA@mail.gmail.com>
References: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
	<xmqqfv4087b8.fsf@gitster.dls.corp.google.com>
	<CAEcj5uUmsV5xzONaahkEEp7R80_zunSAiwTE2UeSxdS6wo1xmg@mail.gmail.com>
	<xmqqr3nk6pk9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nicola Paolucci <nick@durdn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:43:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNW1-0001eu-3B
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbbHCVnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:43:20 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35374 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbbHCVnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:43:19 -0400
Received: by wibxm9 with SMTP id xm9so139764371wib.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BPaBgGeYvIqpYEFK+SvIuxtJYWEujjNezRAL11QX+CM=;
        b=pAfqf6ONNXlouThpK8KWQhtJ+Ekf+/cGhL/SuWk/W1hA682D+dTrxDNKAz3Hpx/e2J
         +KPFcdp1G+JaplwtIt+sbMm+ER99WX3cgxQqa1+CEhF//2uA/plpwOz9KFEeJlFGaL2/
         Y+qE2uvI8vb8WK11mYNN2138h8DV9eW/73LA+gGpw/D3hP11xZq6AbmIKWP5o4DMQK9I
         yIpHfqcWCNEbSVswHQS/MEka2joCIIJMswYM5Bx5dpY5xwx3r+9Jj7AT1uVq3rh4WZg2
         XZc13mqWarD1K+QEJpYl5MrOZqawz2RThaTVIohmAMwrBBqYEUhCQf+OetOlNcDGr8lt
         zZ2g==
X-Received: by 10.194.90.171 with SMTP id bx11mr285553wjb.129.1438638198715;
 Mon, 03 Aug 2015 14:43:18 -0700 (PDT)
Received: by 10.27.47.137 with HTTP; Mon, 3 Aug 2015 14:43:18 -0700 (PDT)
In-Reply-To: <xmqqr3nk6pk9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275212>

On Mon, Aug 3, 2015 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I hope we can attract more contributors in the future, so the weight
>> of this doesn't lie too much on his shoulders. Perhaps we should send
>> out the draft earlier next time, and beckon for more contributions
>> from the list.
>
> Yeah, that is probably a good idea.  I was sort of surprised that
> you announced to publish it in a few days.

There's no deep thoughts behind the scheduling. I just followed the
pattern of how Christian has done it in the past. If anyone is
preparing something concrete for this edition, let me know before
Wednesday.
