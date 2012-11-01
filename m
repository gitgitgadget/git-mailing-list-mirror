From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 10:47:41 -0400
Message-ID: <CACPiFCJ2z38jTwrFpQQC08184JB5XkQ4q5c=yXvuGonY5WYKpQ@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
 <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
 <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
 <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
 <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
 <5090EFCA.7070606@drmicha.warpmail.net> <20121031102712.GB30879@sigill.intra.peff.net>
 <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
 <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
 <20121031185903.GA1480@elie.Belkin> <CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
 <alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server.info>
 <bec4d263-b458-4636-9fa6-1c1202416810@email.android.com> <CAMP44s2G2MGuPH-UXfoKNOpx0cuSE87Uz=6B-7H1MzJHf6VMjA@mail.gmail.com>
 <50927D29.3020703@lsrfire.ath.cx> <CAMP44s0TVQOKc=Ce_k1DTwZHuPUmroOaVMPg4t--bmt=3fDPuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:48:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTw49-00087D-Hu
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 15:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab2KAOsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 10:48:05 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:37145 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab2KAOsC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 10:48:02 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1195463dak.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r5o3mym3ys7TAFdeNj01yxYkz1ol9a0RQuZ+UKGMR5A=;
        b=c0hBT4ChTzPpCWzibyKOOMsuN/CaeJT2eJ+Hl60Qjf0TE+42UG47KcXaYzwpo5rumN
         9toOn/mLd0b4aVDjIsZQDMSrm7ldkTejBDW90FSnOPeW3DwkM4hPMz8+T7sUKC1tt6+V
         a33bR9OjDqEKA0yrCiOe3fJrZqXXIojwpg5aeFUx3jz7kTy3iMaUFA/dXnQGn1yyvLFo
         CIsw5oxoWUOPenSQtB0OqAKkQcURLp4J2ZT9ueAMAo8NsUfgUrGslfp6KZ8466Ox/7k0
         FQ0lG6WbY9ZNmTFUXEuDvAH7vtJvnwOKmNWYnyPx3+ifypvG/R0nlMGfKQQFd2ZZowLO
         EgDg==
Received: by 10.68.224.69 with SMTP id ra5mr122552315pbc.114.1351781281548;
 Thu, 01 Nov 2012 07:48:01 -0700 (PDT)
Received: by 10.66.190.100 with HTTP; Thu, 1 Nov 2012 07:47:41 -0700 (PDT)
In-Reply-To: <CAMP44s0TVQOKc=Ce_k1DTwZHuPUmroOaVMPg4t--bmt=3fDPuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208878>

Felipe,

I'll invite you to reread some of your words:

> That being said, I did wonder what must be going through his mind to
> not see that as obvious,
(...)

> Following the guideline of always assuming good faith

So perhaps it does apply that you could try to assume good
intellectual faith in others. When you wonder "what must be going
through his mind to not see it as obvious"... you should consider
"hey, maybe I am missing some aspect of this".

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
