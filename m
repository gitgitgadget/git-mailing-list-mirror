From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 10:18:07 -0400
Message-ID: <CACPiFCKHpHPL9jGgqhEAGyK=K8UyytUUe9z6D7P1RzFPB-8q0w@mail.gmail.com>
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
 <50927D29.3020703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:18:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTvbW-0005nf-32
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 15:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761537Ab2KAOS3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2012 10:18:29 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52124 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011Ab2KAOS2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2012 10:18:28 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1760126pbb.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=j+cjxZ8efGNoDaxjKeM0cejFtMC4iN7qUWdfIiuGXcY=;
        b=yoP/4CrzEQe9pHpRfYln2Wxa0d2Uva5uj/8JrfNyyt5C6R0WSTklMjytz8om5mUbaN
         fMOmNQ8vcT8IcJuF7YwsbqtYJgVdc4vtJLKndsRLUjMJe9zOHAAPv7+sUBa66dK7sHoB
         zUDkxENPrp2hzECTivd/0qfQTiVVML4LQV7skPWfapal8CR2zRKQiGXG1tcvEAhGQEI4
         xZe36I0DLeJ1F8a02uhkleDyd+eOxyySvoXPllLc9j3Z8d7vvzRPIeqQN+X1EMQ5mhg/
         On6f8PO4gaczK/IV5NCD5+PaLW/Vy2aN/IYwdJiDmDhFWwGRN7SMFSeajFRInWbY8HOA
         YAvw==
Received: by 10.66.85.10 with SMTP id d10mr111595845paz.52.1351779508069; Thu,
 01 Nov 2012 07:18:28 -0700 (PDT)
Received: by 10.66.190.100 with HTTP; Thu, 1 Nov 2012 07:18:07 -0700 (PDT)
In-Reply-To: <50927D29.3020703@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208876>

On Thu, Nov 1, 2012 at 9:46 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> You probably didn't intend it, but your sentences at the top can be r=
ead
> more like: "This is a logical consequence.  If you don't understand t=
hat,
> your mental capabilities must be lacking.".  That's obviously (ha!) a=
 rude
> thing to say.

+1

> Also, and I'm sure you didn't know that, "Jedem das Seine" (to each h=
is own)

Ouch! I sure didn't know that. Thanks for that tidbit. Working with
people from all over the world always teaches me that I might be
saying the wrong thing... accidentally. And to be tolerant of others'
sayings.

{ To dispel any confusion, no, I am not German. I'm from a big
melting-pot of peoples :-) }




m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
