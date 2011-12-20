From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Tue, 20 Dec 2011 01:55:55 +0100
Message-ID: <CAD77+gS0qUbsCA-Aba9rAyAf-EGZ5jDtsBuwmp7aM+0tf+rQcQ@mail.gmail.com>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
 <BANLkTimTszUC+4d3tMTP-cxG3AoWmr08HA@mail.gmail.com> <20110418004550.GA2529@elie>
 <1323838492627-7092383.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: johnnyutahh <git.nabble.com@johnnyutahh.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 01:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rco0F-0003iR-FF
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 01:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab1LTA4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 19:56:19 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:35405 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab1LTA4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 19:56:17 -0500
Received: by wgbds13 with SMTP id ds13so8169839wgb.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 16:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NRCWvJj/0gtRLI8530vhcG9tTjPLrlXojKXYHoqf3nc=;
        b=oIqTmhHpAMcsMwEoKZ8Y4ivOvz2zOB+pIag/AKFFsCFzbCenP7ghq2p7b1QM48paCz
         xvMu1R88vTLklKEx7YJl9riCxLcFzvGP9MII2Lzot/CL/XWWheYMiFqQDxQCSjrAP/Vs
         MJ9H5Y+Kk23jT3TTK2yi0kMmkwgvw84zl2n7M=
Received: by 10.180.77.42 with SMTP id p10mr29798wiw.5.1324342576452; Mon, 19
 Dec 2011 16:56:16 -0800 (PST)
Received: by 10.216.10.208 with HTTP; Mon, 19 Dec 2011 16:55:55 -0800 (PST)
In-Reply-To: <1323838492627-7092383.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187487>

On Wed, Dec 14, 2011 at 05:54, johnnyutahh
<git.nabble.com@johnnyutahh.com> wrote:

> Any further movement on this topic?

Not really. ATM, our best bet is to agree on a language and just implement it.


Richard
