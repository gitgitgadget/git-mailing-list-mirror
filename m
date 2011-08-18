From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/4] difftool--helper: Make style consistent with git
Date: Thu, 18 Aug 2011 09:49:33 +0200
Message-ID: <CAHGBnuPRsh0WDVSFr0X1Y+nb=94pJVv8=evFQCjdcd_y9ux97A@mail.gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
	<1313652227-48545-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtxMB-0007Nq-F4
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab1HRHte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 03:49:34 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42094 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059Ab1HRHtd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 03:49:33 -0400
Received: by qwk3 with SMTP id 3so1134267qwk.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YukF4WFJoj3t0CUP2W4yF1dRFvG+RDLADtvTZeT6+tg=;
        b=VJVTwxKXkkxr+SmIAja6PEiEen2Hsg3Gm9eJiiCw84J7tPuRBMmRdgdNHQwH21xo9+
         eyy3pOxe+hKtEjoQfvHJTAKhWB3rixGSGN3OmqZm0y8oUmIPPtpetP8NFO0Py4kIpa80
         22kDGVE1WdTk40Z8qix44klMZXbmUq/LViR28=
Received: by 10.224.206.202 with SMTP id fv10mr328944qab.130.1313653773042;
 Thu, 18 Aug 2011 00:49:33 -0700 (PDT)
Received: by 10.229.182.11 with HTTP; Thu, 18 Aug 2011 00:49:33 -0700 (PDT)
In-Reply-To: <1313652227-48545-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179577>

On Thu, Aug 18, 2011 at 09:23, David Aguilar <davvid@gmail.com> wrote:

> Use the predominant conditional style where "then" appears
> alone on the line after the test expression.

I support your effort to unify the style, but for my personal taste it
has gone the wrong way :-) Even if "then" on its own line was the
predominant style in the merge scripts, I would have voted for putting
all "then" in the same line as "if" as I find this easier to read and
comprehend. But then again it's obvious that such a change would
polarize ;-)

-- 
Sebastian Schuberth
