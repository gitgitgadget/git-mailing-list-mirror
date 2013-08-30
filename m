From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Fri, 30 Aug 2013 14:11:11 -0500
Message-ID: <CAMP44s0yxaS3YeF5gprTecfa0rzLso96cE9gWM629iM0Sc5+Bg@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAMP44s3=gRwORdxYiXnioufg8Ag3tmuZth5_-+NbJWV_v1FDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 21:11:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFU6I-0006Vq-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 21:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab3H3TLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 15:11:15 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:32955 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab3H3TLO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 15:11:14 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so2091076lbi.32
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lfS1EW6Er8BmEtGkIkTLG/o/6WBtfQ52NP1rwie0uB4=;
        b=wpJegWI6L6qau9qHGyx4PoASghAggBLjCqGNAemAUdCziWckTz76tIvn2FUL3pSCC+
         Wal2KB7CT8Uj5Nw/LlCyuAHmvLW4bLs7k7Vz4J9Q9jyX/8M03IrdeJe1bPJTuUsql95q
         Up9SajUFMXayQh5F4LJSTQqFyYJcAhGL5j6I2C+qvS8k2Yz5lbVfKT6hMCE7NZoSnqpY
         TQ4mZeVdFGFMy6wxGwsACyOEFnL677Uy1+SooX6XQDCdueuZQvLQAfNhdUJbS82C0WMw
         4+iCdLWS8U4iqNXPSBC0+I8IjVuP2cLg7Vf+7laO+tGhtSQkF3vkJEv0WxQrMWEfSXw0
         3yvQ==
X-Received: by 10.112.155.228 with SMTP id vz4mr2579100lbb.41.1377889871377;
 Fri, 30 Aug 2013 12:11:11 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 30 Aug 2013 12:11:11 -0700 (PDT)
In-Reply-To: <CAMP44s3=gRwORdxYiXnioufg8Ag3tmuZth5_-+NbJWV_v1FDxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233462>

On Thu, Aug 29, 2013 at 2:57 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> Again, *everyone* has agreed that index needs to be renamed, and
> "staging area" is the best option.
>
> Do I really need to go through all the discussions and list each and
> every person that participated in them, and show to you how everyone
> agreed? Can't you just go and read them again? There was a single
> person that didn't like the term "staging area", but he accepted that
> index is definitely not the right term (Drew Northup).
>
> Here are the threads once again:
>
> http://thread.gmane.org/gmane.comp.version-control.git/197111
> http://thread.gmane.org/gmane.comp.version-control.git/166675
> http://thread.gmane.org/gmane.comp.version-control.git/115666

I take it you still haven't read those threads, and you don't plan to.
So I have to go through each and every comment and summarize what each
person concluded.

Hopefully you would come back to me before I waste my time, but it
seems there's no other way to make you see the reality of what was
actually already discussed and agreed.

-- 
Felipe Contreras
