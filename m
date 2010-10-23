From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv4 00/21] git notes merge
Date: Fri, 22 Oct 2010 18:38:12 -0700
Message-ID: <AANLkTi=QSNztkRHaGdLS=LUFMxLRWQaQTtCLymBRZ9r2@mail.gmail.com>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com> <201010230028.34255.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Oct 23 03:38:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9T4B-000107-7h
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 03:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab0JWBie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 21:38:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51600 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab0JWBid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 21:38:33 -0400
Received: by yxn35 with SMTP id 35so1147025yxn.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=sw7FNHeIPh9K8+AdMyx4f5PRsa7Xqx2vLd+ogz9dJNU=;
        b=r4Gr8PVC3XQWNzvsoZ8Ou0DenhYM4zBbP4Sn4IOdQdrGBA9H5UMKU4ketRKiM6tTYV
         zaqnonP/K9xo0zKTeteV36CBUI3HnZnWXpP/XQsxWOZFMT/PU7AMAHY3xXdEW1aFcxml
         ora4TX0nLRO9OgdYtRNJ8BXOLWPcZfbuyOwDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=m5ky2HYTd8LBXZFtap5TJmDMULMIbAiIE5jC/gC0oRm51qkjSYxcCf8ugJtT702dX1
         2rwPMg3BfoAA89gg8/NZV1H/7Uro9WBebmIDCNb0SbqJIuctoxg79a3gSOKKEY2iqX3P
         7v3wCYJa4honum0Yt4RwTLE5X7f8Gn0Benl1E=
Received: by 10.151.92.9 with SMTP id u9mr7256431ybl.319.1287797912531; Fri,
 22 Oct 2010 18:38:32 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 22 Oct 2010 18:38:12 -0700 (PDT)
In-Reply-To: <201010230028.34255.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159769>

Heya,

On Fri, Oct 22, 2010 at 15:28, Johan Herland <johan@herland.net> wrote:
> Which leaves warning about "other" additions/deletions. We could certainly
> do this, but I'd frankly rather get the current patch series through without
> broadening its scope. I've been sitting on this far too long as it is. I'll
> keep it on my TODO list for a future series (if nobody else beats me to it).

Fair enough, I don't think anyone will be seriously hurt by not having
this (especially since git notes is still more or less a 'beta
feature'), so I'm in favor of getting this merged now, and polishing
it more later if we decide it needs more polishing.

-- 
Cheers,

Sverre Rabbelier
