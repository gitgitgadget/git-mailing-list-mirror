From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 11:24:18 +0100
Message-ID: <CACBZZX59PiO0GGfPg=Gn0h_yWFnAMxmtDtecv9Yd_Pu8Jz0gzg@mail.gmail.com>
References: <1322546563.1719.22.camel@yos> <20111129090733.GA22046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bill Zaumen <bill.zaumen+git@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, pclouds@gmail.com, spearce@spearce.org,
	torvalds@linux-foundation.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 11:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVKrl-0006rj-P3
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 11:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab1K2KYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 05:24:41 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51875 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab1K2KYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 05:24:40 -0500
Received: by bkas6 with SMTP id s6so310984bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 02:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0YPYvoEqt9yWCBTv0gHVi3NHf+hnFlBKbT5WAp1SuJg=;
        b=YVQa7OZFRZbZCBuRzsgjKG8PtL59Q+bYaHcF9oyL5IoWxzV84H0SOe370AZriZwn9l
         INQUTT5DLir/nOH1DYD5SboCkoJq6NrysIWZRliif718NWw3giR5W2eyL3JyDRkRTIjR
         IX5zslDJbsw6YtmVpxrZN8c4WQj3nMmIb5zfU=
Received: by 10.204.132.89 with SMTP id a25mr44611966bkt.85.1322562279205;
 Tue, 29 Nov 2011 02:24:39 -0800 (PST)
Received: by 10.223.72.195 with HTTP; Tue, 29 Nov 2011 02:24:18 -0800 (PST)
In-Reply-To: <20111129090733.GA22046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186050>

On Tue, Nov 29, 2011 at 10:07, Jeff King <peff@peff.net> wrote:

> However, it may be of interest that the Sun is expected to burn out in a
> mere 10^10 years[1].

Off topic, but it's a a lot sooner than that. The total age of the sun
is is around 10^10 (10 billion) years, but we're already ~4.6 billion
years along that line.

However the Sun is currently in a stage of gradual heating until it
turns into a red giant in ~5 billion years. In around 500 million
years the earth will be uninhabitable as we know it, and in around 1
billion years the surface will be hot enough to have boiled all the
oceans. In other words the earth in a billion years will probably look
similar to how Venus looks now.
