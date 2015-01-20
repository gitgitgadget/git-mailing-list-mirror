From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: Unused #include statements
Date: Tue, 20 Jan 2015 13:08:35 +1100
Message-ID: <CAKJhZwRnu-jHydGzzXJeUrkhzK29mX7NAabF88r-ry-YrY6q9w@mail.gmail.com>
References: <CAKJhZwR+iMYAMCxurgc7z2dhqoqx_RxV1G4Jh3phPAOGptp_XQ@mail.gmail.com>
	<CAObFj3wC6ezNQfAYvtepBdW3S0hv8c4_fXYTo-zp4wwddx3QXg@mail.gmail.com>
	<20150115063307.GA11028@peff.net>
	<xmqqvbk77u9m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Robert Schiele <rschiele@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 03:08:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDOFF-0002lE-9r
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 03:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbbATCIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 21:08:37 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:45893 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbbATCIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 21:08:36 -0500
Received: by mail-ie0-f180.google.com with SMTP id rl12so838313iec.11
        for <git@vger.kernel.org>; Mon, 19 Jan 2015 18:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H9/mx51iDZ6Y/cGP+0B9SRaPnHx1w7+Knmkacg3Wzj0=;
        b=lmwXyjCC4mCra9Kecv5kJdFGG2oLOHrqdzKPnUfjcvCrbQ2W+ZDdWRdPKykxuYE0m2
         U3VKB3Ykre6DH9YHtsPaevT/T4LLaPE6pOp2SwoD6TOCSl4PidofaYxE9glEx0i01fbJ
         gHFCoV+dAfJuoLQgLVvwcrSzcKP4j4+W44NK1O3mITm5in4euZt8A+45zuhMxddf0ZSb
         UrBuyWs4GaHEpSwu0UzMZu80upfY8wghAMDCx0aXgm8Wfpu58wleqMS0rkTWqsD9nTl6
         yegXkFRk7lNB2hKN/axDF0UynHCX/1qbHaQH5cxYFmfF8g3maVUIYWvT15BTxqypwcY+
         9NEg==
X-Received: by 10.42.83.147 with SMTP id h19mr7071180icl.95.1421719715479;
 Mon, 19 Jan 2015 18:08:35 -0800 (PST)
Received: by 10.50.6.197 with HTTP; Mon, 19 Jan 2015 18:08:35 -0800 (PST)
In-Reply-To: <xmqqvbk77u9m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262647>

Robert, Peff and Junio.

Thank you all for your feedback. It's clear now what sort of analysis I should
aim towards.

Thanks,
Zoltan
