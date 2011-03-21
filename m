From: Vicent Marti <vicent@github.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Mon, 21 Mar 2011 02:38:17 +0200
Message-ID: <AANLkTimBCH1FhzoUjP-sA2zM2DhVLiPRbLa3JLZg_Ma=@mail.gmail.com>
References: <op.vsm1yszq2m56ex@localhost.localdomain> <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
 <20110320234420.GA1919@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pavel Raiskup <xraisk00@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 01:38:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1T8t-0004Vo-Sx
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 01:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab1CUAij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 20:38:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40012 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1CUAii (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 20:38:38 -0400
Received: by wya21 with SMTP id 21so5338331wya.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 17:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=ZdNwBywKpE28H2YoqxJ2nIwjurIDnOdReYduhnNvZAY=;
        b=izeYqNZxh+UKnRZqxscrrUlnbFpz6rGJxFlrE88hJVRucrKU4KWamWuQt3akYu+6D8
         m45T9ERxPLysIso0DTVf6RKl2NJmK73c0uCtOFqfEthqNf7HPGMQmY1JceCGXCBCsiON
         RAtpBzBdIesPGjFhKZN3ssi3AmkBFvTcg4qdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=aQ4061mLEX1QimahwS9DNxtpH0VVAsDLjDSBNGY+0IzIvrOo2aOiuwIlsqJE8RZpLW
         suYIOAICCT7T8SWUOXZe2EthJhaGGxeWrvoI3wo+U/qLsNvSrQ9Btft7LF7kZjEclPpI
         0u7F3QE6K/0IaydzuV2IeeGr2yTbdHJt08lN4=
Received: by 10.216.238.194 with SMTP id a44mr3444462wer.51.1300667917098;
 Sun, 20 Mar 2011 17:38:37 -0700 (PDT)
Received: by 10.216.243.7 with HTTP; Sun, 20 Mar 2011 17:38:17 -0700 (PDT)
In-Reply-To: <20110320234420.GA1919@sigill.intra.peff.net>
X-Google-Sender-Auth: sOPLikaMblZLEUFiBEPNBk9QSO4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169541>

On Mon, Mar 21, 2011 at 1:44 AM, Jeff King <peff@github.com> wrote:
> Yeah, I would be happy to mentor or co-mentor with Vicent on a project
> like that. Not only might it be useful to actually _use_, but my secret
> motive is that I'd like to start testing libgit2 using some of the
> regular git tests, both for interoperability and for performance.

Right on! I've just added this task to the wiki so other prospective
students can take it into account, and listed you as a possible
mentor.

While I'm at it, I removed the "merge libgit2 into mainstream" task
from there. Feel free to re-add it again if you find a suitable mentor
-- I'm getting diarrhea just by thinking about it.

Cheers,
Vicent
