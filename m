From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Tue, 13 May 2014 17:47:18 -0500
Message-ID: <5372a0f6650d2_36c411ff3002e@nysa.notmuch>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
 <53729b2150a84_34aa9e5304e0@nysa.notmuch>
 <xmqq38gdmhdo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:58:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLeN-0002po-H3
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbaEMW6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:58:16 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:53075 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbaEMW6P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:58:15 -0400
Received: by mail-ob0-f181.google.com with SMTP id wm4so1216754obc.40
        for <git@vger.kernel.org>; Tue, 13 May 2014 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=zM6YAx5tBmsmJ4yBOSmZHAVa8hCmxH77UC+KrbEzHOU=;
        b=jAlpxh+jYoG00D2yrpbFlhZKC+PgDCnUiq6OB4kBwnd5rlcS72qQeC8PeaxZ4q4CPR
         hGbdn63aPNmojQJZGZD/2CwqCQr5eWsC5joyEIOyi4nzjReXXhuh3yZKKELYwUCI6ZHN
         oUbjNT+BKaavli6fKssKY4uVEm7vmrkxVm9n6lDW5FJSBJ5pk6wQYojydD6cgXyd2CP+
         jqfdklURhskWuhpTNrXVdsP72W41GBY3TibuHsF8RyaCxK0MMIoB03RPX//IVyZs9YeH
         dug+j71sLfxDu0IGIOxtpdLwaQdR8UPRXj/d0sx6fE0Rr3IEe5U7CoiAXKsLVGIMfKaK
         7psw==
X-Received: by 10.60.51.136 with SMTP id k8mr2282807oeo.33.1400021894928;
        Tue, 13 May 2014 15:58:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm28443921obb.8.2014.05.13.15.58.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 15:58:14 -0700 (PDT)
In-Reply-To: <xmqq38gdmhdo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248882>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Sigh, you just don't seem to understand that you are thinking about a
> > different issue. I don't think there's any other way I can explain it to
> > you.
> 
> Perhaps pointing out which commit(s) to revert might be a good point
> to start.

Oh, now you realize it might be nice to avoid this regression I warned
you about.

Why don't you continue schooling me about what constitutes a regression?
I'm such a slow learner.

I was going to do more than pointing to commits, I was going to provide
the fixes with test cases and a detailed explanation. But then you made
your decision.

This patch is what I'm suggesting you to do now. And I'll repeat what I
already told you.

Good luck with your tree.

-- 
Felipe Contreras
