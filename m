From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 1/2] am: handle stray $dotest directory
Date: Tue, 18 Jun 2013 20:14:40 +0530
Message-ID: <CALkWK0kQwyM4UD_mVkHKdVT-j+gxgg3quZN70jnE3tUO7m6bzA@mail.gmail.com>
References: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
 <1371300192-6222-2-git-send-email-artagnon@gmail.com> <7v38shjw01.fsf@alter.siamese.dyndns.org>
 <7vy5a8ei6u.fsf@alter.siamese.dyndns.org> <CALkWK0kq6+K4fotWq1Qz9BrqOG56NezJqnfH9Xrg1vh6AS9bnw@mail.gmail.com>
 <7va9mna3tm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:45:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uox9z-0002AA-5l
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab3FROpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:45:23 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:51307 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab3FROpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:45:22 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so10144847ieb.38
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jzGhrPz7v2fxW3MMDZ48AGGDet6pWmpR9rwz8wAuAmA=;
        b=TH/aVXTQ4Mm1SdOxrc+9/wl213grlZDNiFfeqqgo1ANpzdTUSV6Pl/reqNTG/TyFy2
         bt9dtbyrzMV34tTtPtiXFlqJd/dsilgFbu48/yWxdH6zUf5Es98YZL+CYEmSX4d414ST
         2SCNfxYbuI2Px9wU7Kassvp+Wr5YC6ylENMbPFVjmmu/C4yviYEAa3G2AW2BjYli+jCX
         8+puAemefj6bf3NNYqXcd8mx28FJyzcBY3sqmqs3DpowK4k8XVGzwvja6vgJrTQWbyHY
         50EcPLzlr0INHIPsDgNLZzIF+UI5FuXgQ2Uf7tYPD9nyLbFSbllfiAXu14FQseRg1aYF
         YDUA==
X-Received: by 10.50.154.106 with SMTP id vn10mr7669237igb.0.1371566721901;
 Tue, 18 Jun 2013 07:45:21 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 07:44:40 -0700 (PDT)
In-Reply-To: <7va9mna3tm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228244>

Junio C Hamano wrote:
>> Where did the error occur?
>
> I think you can compare what is in 'pu' and what you sent out
> without asking.

Ah, I sent out the series before I taught Emacs to indent properly.

Thanks.
