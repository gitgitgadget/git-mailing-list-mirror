From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 8 Mar 2012 08:18:48 -0500
Message-ID: <CAFouetgY+HSFksZkOGHcD41kHwfedtta0XoDemwyfQKOiJM1RA@mail.gmail.com>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Thu Mar 08 14:19:18 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S5dFO-00019g-IA
	for glk-linux-kernel-3@plane.gmane.org; Thu, 08 Mar 2012 14:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab2CHNSx (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 8 Mar 2012 08:18:53 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48532 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab2CHNSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Mar 2012 08:18:49 -0500
Received: by iagz16 with SMTP id z16so683619iag.19
        for <multiple recipients>; Thu, 08 Mar 2012 05:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+mP8yuqXk3zVcoJBJiUY0u7dPrmjhMbqd8g5D44mYj8=;
        b=sA7fsVSYrMQTVXRO/kM/zggrxeic7U+e30ocYpQJXGc3MhcVDy9rqQEgCLhw+1JNeJ
         xmT/cOaavj/dAbXNgwOId4miOYT47+4fdwV+D7xxbZPUj6Xw9ou8QDolb1T53FlHcqid
         Y+OFCDeSF1XjHEHXnIkz4RMFg37/zddj6LtoohjJMnXpCow1U+D8iBQ46xYEZTnDRTym
         vZeuOk1jUD3PAkfjs3uCT1BJVJcz3XCDC4k2+TdfA0i3Bl9d1L26r1+6BicfumKsKyzv
         xePCTHpy9cimCf86Vkf1jUPKLSwwniYJAbewvTMI40PrJKprFGR8JFjoo3Qs1nNjnXcc
         /ddQ==
Received: by 10.50.140.106 with SMTP id rf10mr16949372igb.36.1331212729056;
 Thu, 08 Mar 2012 05:18:49 -0800 (PST)
Received: by 10.42.218.65 with HTTP; Thu, 8 Mar 2012 05:18:48 -0800 (PST)
In-Reply-To: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192597>

On Wed, Mar 7, 2012 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Updates since v1.7.9
> --------------------
>
> UI, Workflows & Features

Are additions to contrib/ normally mentioned here?  If so, this the
first release to include "git diffall" (commit 1252bbe1c685).
