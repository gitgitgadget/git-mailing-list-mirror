From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 03:58:20 +0100
Message-ID: <CAMP44s2G2MGuPH-UXfoKNOpx0cuSE87Uz=6B-7H1MzJHf6VMjA@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<20121031102712.GB30879@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
	<CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
	<20121031185903.GA1480@elie.Belkin>
	<CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
	<alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server.info>
	<bec4d263-b458-4636-9fa6-1c1202416810@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 03:58:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTkzL-0004Jh-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 03:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343Ab2KAC6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 22:58:22 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61700 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787Ab2KAC6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 22:58:21 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2157950oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 19:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b7pO5x+jxJdWAr/zmUIdNxzgS35I7cHlHduRkeMx8w0=;
        b=wQgeYNSoev1dPQfNU0c7tPOdWz+swNWHRdZohk9mBxz1LC9o8Y13rLPJw5kQoXObLC
         z/VfDfDb6tZm54w/2EPjkEPLhSEmz/EcrSWrOGwZrQluKzTpEmA1GPsa2hcb6THyn1eP
         I4rhFIRGB5zhU/QAAgh2bu6BAg6XVY6yLHfw+XHmvU9cu4ft4fogQVnd/j9CqShiD5xt
         7nfiSDrZdMl/5thsYmiPvgHK9lxaO5U6pG9BVDz5jD7HXmFBq8rEB4Lk2ifguEnXnmev
         rreMpVJNYFfqtwcwBiYK0bAR6yyt+eU8ZaawY3ZBF9BgHxfO49mNi2HVtBhoqgoyxQsz
         VitA==
Received: by 10.60.12.233 with SMTP id b9mr33942634oec.95.1351738701000; Wed,
 31 Oct 2012 19:58:21 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 19:58:20 -0700 (PDT)
In-Reply-To: <bec4d263-b458-4636-9fa6-1c1202416810@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208863>

On Thu, Nov 1, 2012 at 2:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>>On Wed, 31 Oct 2012, Felipe Contreras wrote:
>>
>>> It doesn't get any more obvious than that. But to each his own.
>>
>>In my opinion, Jonathan does not deserve any of such condescending
>>words.
>>But maybe the Git maintainers are okay with such a tone on this list?
>
> Agreed, and no.
>
> We've been hoping we can do without a rigid code of conduct written down to maintain cordial community focused on technical merits, and instead relied on people's common sense, but sense may not be so common, unfortunately, so we may have to have one.

Just for the record, what exactly is the problem with the above?

1) The fact that I say it's obvious
2) The fact that I say everyone is entitled to their own opinions

I don't think I said anything else.

-- 
Felipe Contreras
