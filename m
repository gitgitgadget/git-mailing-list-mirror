From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2011, #02; Mon, 8)
Date: Tue, 9 Aug 2011 11:06:20 +0530
Message-ID: <CALkWK0m7UCuPbdB5k4KS9MfmGvYOjPDkSP_aFFp0A3QETg9k7A@mail.gmail.com>
References: <7v8vr3v7az.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 07:38:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqf1R-0000kz-Dk
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 07:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab1HIFgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 01:36:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35128 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab1HIFgn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 01:36:43 -0400
Received: by wwf5 with SMTP id 5so2279080wwf.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xuuy8ZVhGhDYa0sSpXQ35tLrAmspd22wuAc7uQF57eg=;
        b=VyjRN4LAF0WozuhBKiv1NRAQ1ssA9dzSJGK0ScuaOrRf1tPP1WaUxzxqtir2Et6rv/
         ZjtUbNM24HtBTFpePbduUuiSQ3ZbU0x19UKqswi0dDy8T5s1B7LyKoJzxKOwC4gTYxGj
         Ziq1Gc+sipO1zL/fnJETEsBWuww15DjfvdXOU=
Received: by 10.216.168.198 with SMTP id k48mr1619124wel.109.1312868202603;
 Mon, 08 Aug 2011 22:36:42 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 8 Aug 2011 22:36:20 -0700 (PDT)
In-Reply-To: <7v8vr3v7az.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179021>

Hi Junio,

Junio C Hamano writes:
> * rr/revert-cherry-pick-continue (2011-08-08) 18 commits
> [...]
> Getting into a reasonable shape. Is another round of re-roll coming?

I certainly have no plans of re-rolling.  Although there are times I
wish I'd done a few things slightly differently while developing the
new series (on top of rr/revert-cherry-pick-continue), I'll refrain
from making any changes to this series.  That little ugliness is the
price we have to pay for my lack of experience :)  All the recent
reviews have mainly pointed out nits, and I really don't think there
are any other urgent issues with this series.

Thanks.

-- Ram
