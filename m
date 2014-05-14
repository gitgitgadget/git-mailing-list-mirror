From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Wed, 14 May 2014 15:51:55 -0500
Message-ID: <5373d76b965c1_592416ad2f8ca@nysa.notmuch>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
 <53729b2150a84_34aa9e5304e0@nysa.notmuch>
 <xmqq38gdmhdo.fsf@gitster.dls.corp.google.com>
 <5372a0f6650d2_36c411ff3002e@nysa.notmuch>
 <5372D205.4040004@gmail.com>
 <xmqqppjgji2s.fsf@gitster.dls.corp.google.com>
 <5373c6668871b_56d6e3b30451@nysa.notmuch>
 <xmqqha4sjelx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 23:03:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgKH-0004jY-Uc
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbaENVCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:02:54 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43640 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbaENVCx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:02:53 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so155731obc.33
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=XL1m2RjMlY5LfXThfhQ95f4mXgFfiDypJgZ7WXcUU7g=;
        b=olEGsewPmELitcXTObcG3bM1uR9A4s7hnGhq0LRen8c+thtsH63tK/190afky8SHUJ
         7N3kkQfWKpdYcChV0/xwRcl2WW/5XAs0zTR3z9vgNDKbo0zbKGW7zjJPt3GKSKLYbonX
         zDgRubibF5wdULVG0vqhag2qUhSBzOH+NLOE92FkfjxrtqzV9dwgk1SEg0Wqo5tSSfyn
         TLawzpZkv4XD9irGiC2GGqhbaqwQ+gxKQZlhiJKhmGUVN27kftbVtARTV7O4zQD77BUQ
         4sPMlCSwTvlqzbxkOF1FTwE5dvXz4tTY13X+kJmbD28UmIiW3bD7OyEkOP8B2EGW3bKK
         Df5Q==
X-Received: by 10.182.2.72 with SMTP id 8mr5960446obs.21.1400101373134;
        Wed, 14 May 2014 14:02:53 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b9sm9858029oel.4.2014.05.14.14.02.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 14:02:52 -0700 (PDT)
In-Reply-To: <xmqqha4sjelx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248952>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> So at this point, I would have to say that the users of remote-hg is
> >> taken hostage by its author.
> >
> > The users of remote-hg are being affected negatively *because* of your
> > decisions.
> >
> > You have the power to help them by answering a simple question. Yet you
> > refuse to do that.
> >
> > It's all on you.
> 
> That is exactly what I would call "taking users hostage".
> 
> I think I already answered that one question:

> in $gmane/248853 with:
> 
>     You certainly are acting like one, aren't you?
> 
> Do you need more?

You know full well this is not the question I asked you repeatedly. Stop
trying to spin the readers.

I asked you here:
http://article.gmane.org/gmane.comp.version-control.git/248683

And here:
http://article.gmane.org/gmane.comp.version-control.git/248348

And here:
http://article.gmane.org/gmane.comp.version-control.git/248368

I made it clear you were not answering the qustion here:
http://article.gmane.org/gmane.comp.version-control.git/248685

And here:
http://article.gmane.org/gmane.comp.version-control.git/248701

And here (apparently deleted mail):
1400013572-30232-1-git-send-email-felipe.contreras@gmail.com

And probably many other times.

And I will ask you once again.

Please answer this *one* question:

1) Please clarify the reason why you blocked the graduation of remote
   helpers. Please give the full rationale and do not point to other
   mails, or other peoples' explanations. If necessary attach such
   explanations to your full reasoning.

This is the *one* question you have refused to answer over and over.

-- 
Felipe Contreras
