Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E95EC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 16:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB7020720
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 16:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgFVQRk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 22 Jun 2020 12:17:40 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60137 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgFVQRj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 12:17:39 -0400
Received: from ThorstensPC ([87.122.230.158]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBE3k-1jiUGB1sgo-00CgoB; Mon, 22 Jun 2020 18:17:33 +0200
From:   <sopq0asmppc9@online.de>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
References: <01af01d6452d$1a91b590$4fb520b0$@online.de> <20200618175232.GI6531@camp.crustytoothpaste.net>
In-Reply-To: <20200618175232.GI6531@camp.crustytoothpaste.net>
Subject: AW: Git commands throw error
Date:   Mon, 22 Jun 2020 18:17:29 +0200
Message-ID: <035a01d648b0$a24170d0$e6c45270$@online.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMRWuR/7tzlkI2tv3H5NbWdSTtXxQEJnC99pmZeSaA=
Content-Language: de
X-Provags-ID: V03:K1:t2lyer7jzDVSBX6+5fDeDKIW3UIbHblRmzXzDyZC7OZmMDS3Tfj
 emoT+gufTL6hMgkyfnRHfYEYNLYBwtJxvQeWJBM11sLVyU64vw4pIr91QmKun8795cSgRyJ
 3TgYSNpAd2KV6lWlwuPsUknvBFQFBIF2PuvjDVPPhKCcjQLI0hNolr2P8bKIc8IQSXbXJX8
 uUI6M5enow129YV7bwPWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j7f21gpWFww=:sIk62LyOKIANE+ePKLa6Qw
 tczUs/V/yLV46/RSOOu+8p8HkKYwO94HlqnmFgEqJNtw5KDWwYs8e0V2dv+/3UzE/gh/8qud9
 U3NRDodl+NkqP5Ghr6RQeXhZ1O8NYl5iEN2+rIwLnsKrOdjjRGg27/TbnnVSwhh1kenk8MPmb
 IvdtIv/KtsAdTq99vBFbEOo77sjO1So6TwbBNxuTcixI/wn6Js+2XTZAjAONJoQe2YM0/xlpk
 jxfjjmFgiNS1YzGzhD+jC/IO8udE++6DBK3eYOpbeub38KwStTv+zsve7iwP2qBtHscOzBl02
 hDWHFE84tXOXfnImDsg+BGpIqtNInEALyWOb4V2Oh7DKks95rknrcIL7F3xShXdT4EWfdtii+
 fST3Dn/uFE35NID/WKNgIdYwjPZ9Yh3V3UyAGBt/Oi4QkkhH9P7RtKUgyHt05gCPqv1jrB4N/
 FQmtb2yh7VX1KJLsXWdnEOKjOFo5RGKiZ72jNwItBrExIXiEltIt4ZghIKzrqIegfk87Ipzdu
 StYBTJYwDWzIFaQ+YzG0tnUTWcJiv4gRpT3SYDDSPPX+5l3IKFguRcOxhpVUT9fHRGHwDzRlg
 ukmTwxKh1zCoxsavcDGti8PaC3bt/hNwHHlyv5c8tRIbAnSdujyWko2y2aghOYOS3dLWoLOfm
 kP77TpAC7qeIXzFvq/76BOw/iVPi8D1AFka9gmRBMPMvgmefUkCcxHlTUVls0OETa4gLo6Usg
 ZXKkB6E8SD7Ca/shWDcDc8kP7YNcgJT13HXV+Kc/7Y0rNfrh1AUNj5vsOTk1cQGzqn+hWU6ZO
 dDanoZ/Rpj9Q2K0AQoa+eWd4sYMytL5q7+n3mqK4ZFdnM32QdQNcBI9JgauTMs/pcizdQTO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

thanks for your advice. I opened an issue on GitHub. Let's see where it takes me.

Regards, Thorsten

-----Ursprüngliche Nachricht-----
Von: brian m. carlson <sandals@crustytoothpaste.net> 
Gesendet: Donnerstag, 18. Juni 2020 19:53
An: sopq0asmppc9@online.de
Cc: git@vger.kernel.org
Betreff: Re: Git commands throw error

On 2020-06-18 at 04:58:27, sopq0asmppc9@online.de wrote:
> Hi!
> 
> I recently upgraded my GIT installation to git version 
> 2.27.0.windows.1

You're probably going to have a better time here reporting this to the Git for Windows folks at https://github.com/git-for-windows/git.

> I have all my repositories on a NAS and now I get errors with all commands, e.g.
> git status ->  fatal: failed to stat '’: Function not implemented git 
> pull ->  fatal: failed to stat '’: Function not implemented
> 
> Setting fscache to false (globally or locally) does not help. Please 
> fix it quickly 😉

When you report this, you'll need to mention which file system you're using on your NAS, since it's probably related here.  You may also be running into filename length problems and you could try turning on long path support.

Finally, something else you could try is to see if some other process is using these files and if so, kill it.
--
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

