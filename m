From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/5] Documentation/git-diff.txt improvements
Date: Mon, 29 Apr 2013 22:49:44 +0530
Message-ID: <CALkWK0=aF2H4b9L32zvFQweYrzsJ-ZoBZ59TcECEasyy5TyvmQ@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <CALkWK0nVZHwSMS_gtisiAguNhAMnDpdWmAtz_OgzP93YZtYfHQ@mail.gmail.com> <7v38u9l2jk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWrkb-0002AC-R9
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730Ab3D2RUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:20:25 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:62819 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757214Ab3D2RUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:20:24 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so7770216iec.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6JYBErEtpUwTRm4Ls3+S5swmyeDiWHSJGZ8jolfIeR0=;
        b=NexHtBKnDY96OkbfGHsLteYdui+YYDNCtDEMTP8xapCyJ7K7c2trLNig2uliYh6fKa
         9pLFKeenPPua0bjTMq8+F+bWVLh7FfkrY53z5aUDV97SsRJ8kLWYRKBi3gQZrerSniiT
         jWsTn9AHKJ7GhTA9DVV3fNEGkwyQMN+yr1rr4pl7jpuvsQAZIfy//wlsAoWkAHXJAGJj
         at/cVew9nY/cdSTTTAWc1JniJqSu4Usr40B1Oioly+UhK+8gyS8ii3ByeN6cTbaPb4wc
         G8ShGBeEU9pbxMZDf9SWtZu3/on0EnZ9439nepajHUd/0P0LT39PKd/rEtS3bOv4Mt2e
         HvLA==
X-Received: by 10.42.27.146 with SMTP id j18mr18461032icc.54.1367256024430;
 Mon, 29 Apr 2013 10:20:24 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 10:19:44 -0700 (PDT)
In-Reply-To: <7v38u9l2jk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222817>

Junio C Hamano wrote:
> I had an impression that many of them, with the suggested fix-ups,
> were improvements, with or without the A~B discussion.  It seems
> that the entire review wasted many braincycles if you are to drop
> the ball at this point, which is very dissapointing.

No, I don't meant to drop the ball at all.  I'm _very_ annoyed by this
inconsistency, and have a burning desire to fix it.  It's just that I
don't want to fixup something now and regret it later, so I'm putting
it off until the A~B issue gets resolved.  In the meantime, the first
two patches are fine and can be applied as is.

> I do not appreciate "Nothing to resubmit".  [1/5] needs fixes to the
> issue Jonathan pointed out, doesn't it?

Oh, I thought it was fairly trivial and that you'd fix it up locally.
Would you like me to resend with the fixup?
