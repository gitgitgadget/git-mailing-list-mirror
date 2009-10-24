From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sat, 24 Oct 2009 17:22:16 +0300
Message-ID: <94a0d4530910240722vd6839f0r49487a3a174fa179@mail.gmail.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	 <20091024220644.6117@nanako3.lavabit.com>
	 <94a0d4530910240708l7cb59b36s8d6ddebd4af48e7f@mail.gmail.com>
	 <20091024141445.GA2078@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 24 16:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1hVf-0004rl-Gb
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 16:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbZJXOWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Oct 2009 10:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbZJXOWN
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 10:22:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:37611 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbZJXOWM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Oct 2009 10:22:12 -0400
Received: by fg-out-1718.google.com with SMTP id 16so4368758fgg.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=o9kKvbGEllpNj0+bDJDaXYgrLdxJlbZRbHU3QKkBYNA=;
        b=heMjKb5u1UiKUvwlIQUKcAnLnn1+DIx1Egfn670X5kqCeVZZjK/1+yzkeePwffcVyl
         +KCTQwHOgDMpGcekpA8uNjSYijatPCZMnEQkvth3W35urkyskEZhb/cnRrDp8ngG9I6m
         wMp3aqPHbht2LzTNHocKQ0m59NtH26mfuvYuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JjQCN5zuo48LonyfU9L/nQFOUSUqDaCuwf+cAhfSZle/bHJDPBr7kty3dr8YbVsmhO
         Rbt5qAG7jMIfdcmCzFSDl2lfFGdG1kokavj2YZmUOFOCFVddWuLDQwTMCPZ6XG4wgyBe
         rmymZzqbgbj90D59tGtYLvsMB6CHhJMJia8rQ=
Received: by 10.86.187.10 with SMTP id k10mr931607fgf.49.1256394136466; Sat, 
	24 Oct 2009 07:22:16 -0700 (PDT)
In-Reply-To: <20091024141445.GA2078@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131166>

2009/10/24 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.10.24 17:08:06 +0300, Felipe Contreras wrote:
>> On Sat, Oct 24, 2009 at 4:06 PM, Nanako Shiraishi <nanako3@lavabit.c=
om> wrote:
>> > =C2=A0Date: Tue, 13 Oct 2009 22:49:40 -0400
>> > =C2=A0Message-ID: <20091014024940.GB9700@fieldses.org>
>>
>> I've no way of figuring out what is that. Most people use a direct
>> link to a mail archive.
>
> Having the Message-ID is quite useful, so you can search your local m=
box
> to find the right message.

I don't have a local mbox, and I suspect I'm not the only one.

> You can also use gmane's Message-ID search:
> http://mid.gmane.org/message_id_here

That's a nice trick, but then using the following link would serve
exactly the same purpose, wouldn't it?

> So: http://mid.gmane.org/20091014024940.GB9700@fieldses.org

--=20
=46elipe Contreras
