From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 18:48:35 -0500
Message-ID: <CAMP44s2Yb+fSWYw0S7WuS-MEjKaSsnvndFw4ryZ8_Og6ioFcTQ@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<CABURp0riKhJ1p+06aKMCnBiupg3LyVCky5XRcPNLyaJDTkip9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 01:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USyZF-0006k5-Sq
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936644Ab3DRXsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 19:48:37 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:48840 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936608Ab3DRXsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:48:36 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so3070443lab.37
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=IhkwiygkVf3ZcZV4WVRT/crdtgNONGeFeLFNj+hnwEI=;
        b=gwrp0bj3UGmplWr4Zg/CxPKbYnDGdIcs/onPLGEfbZMbyK2mBC7MJLECZhK40pQNSY
         qDvcfGs1TD0drp1VL8xjo0GZzu3MvhiMRNUY2B08IJX1QBjk41aKwz3SCBNNwhXk7Px/
         ry1AJWa1Uk02P+7b49Wbhas3G56FUlmSviiRBML3qDB9NXVpjK+EolWdt3hjBpbiMKRP
         h1RvWwRZKJJUUvz9yuD23T/czZ5KOaXht/w5RZyAztl8mtp66isYus4dYxwNbuwJ6Ztj
         ZeTdTiXcLX9myqW4sNHkJahiW1k5EhRSdmg19lQlPSgIjmONtWSGeNGBtRdUaDo2zA/7
         L4xA==
X-Received: by 10.152.27.229 with SMTP id w5mr4350087lag.46.1366328915254;
 Thu, 18 Apr 2013 16:48:35 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 16:48:35 -0700 (PDT)
In-Reply-To: <CABURp0riKhJ1p+06aKMCnBiupg3LyVCky5XRcPNLyaJDTkip9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221717>

On Thu, Apr 18, 2013 at 3:06 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Wed, Apr 17, 2013 at 2:50 PM, Felipe Contreras

>> Yes please. Show me one of the instances where you hit a bisect with
>> any of the remote-hg commits mentioned above by Thomas Rast.
>
> I made no such claim.  In fact, I have never bisected to any
> remote-hg-related commit.  I fail to see the relevance of this
> qualifier, though.

Here, this is what you said:

You:
> Me:
>> [skipping irrelevant comments]
>>
>> I'm sorry, did you actually hit an issue that required to look at the
>> commit message to understand where the issue came from? No? Then I
>> won't bother with hypotheticals.
>>
>> If you want to waste your time, by all means, rewrite all my commit
>> messages with essays that nobody will ever read. I'm not going to do
>> that for some hypothetical case that will never happen. I'm not going
>> to waste my time.
>
> This is not a hypothetical.

If something is not hypothetical, it's real, which means it actually
happened, but then you said you never made the claim that it did. So
what is it? Either it did happen, or it didn't; you cannot have your
cake and eat it.

If you are going to change your claims on the fly, and deny you ever
made them, I don't see much point in discussing with you.

Cheers.

-- 
Felipe Contreras
