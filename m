From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 1/2] pull: handle git-fetch's options as well
Date: Mon, 18 May 2015 22:05:45 +0800
Message-ID: <CACRoPnRQiDxzOy_cGm42ugHkWdKm=rzvzo2vr_5eVy0Q5T2CHQ@mail.gmail.com>
References: <1431955855-16228-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 18 16:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLg0-000829-RP
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 16:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbbEROFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 10:05:48 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:36774 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbEROFr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 10:05:47 -0400
Received: by lagv1 with SMTP id v1so221708320lag.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h1hTm0J81cA4yzLUM538iiXqFjmmASJslqC055cIta0=;
        b=IVnUr+tXuafT+d3tVsNZs4Fh1WGofOrKoCnR3lfMnFYpDruZ+ikoN8TyFnBmnMwOHJ
         iIpIebCJG2jJQJTX+BZHhGYCLwv8bHl6Bg+I9bvP1nz6/TpmlH6p20UeBbjoK+/WvMm+
         IrYGWYxktiCsHznos3CcjNKXr0wH6yY1xEW6bYNuNYd3ME+Pkgdm/PrZ6tWTJ7KVdifE
         s1F3ojjntbM/WzPT3QAX0vMWVObIdjRR6gbZJih/RCfjj4gxJsd2OLLr5PHn4V05v1Nr
         pwn1aLXQDk4BVdNM/ydWxzFDm4vgE8NC/5wNFZhFZSm6TGaofpF+BfCFT7Dvqi+DfqF/
         yg9g==
X-Received: by 10.152.87.204 with SMTP id ba12mr17915862lab.35.1431957945405;
 Mon, 18 May 2015 07:05:45 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 18 May 2015 07:05:45 -0700 (PDT)
In-Reply-To: <1431955855-16228-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269252>

Hi all,

Ugh. It seems I mistakenly sent an older version by mistake (and
didn't even realize). Please disregard. :-/

Please see [1] instead.

Sorry for the trouble.

[1] http://thread.gmane.org/gmane.comp.version-control.git/269249

Thanks,
Paul
