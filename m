From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: windows smoke tester (was Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Mon, 16 Aug 2010 01:39:40 +0800
Message-ID: <AANLkTin2tS-wuaOVepswfsWeubHjf6VRdUULMwWrkb1+@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>
	<AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>
	<AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>
	<4C64308D.8030000@gmail.com>
	<AANLkTikh14FVmE6E78FNRvSG0B_5ZmNcOLSwye4ExNVx@mail.gmail.com>
	<4C647360.50304@gmail.com>
	<AANLkTimp5TSvjcmZG-pGtG6ep3axertqWuooS7e+A3Ow@mail.gmail.com>
	<4C647C85.2080109@gmail.com>
	<AANLkTikuy3q8JrppTr+YPwZHFh2PNk+An2qvdoWiuAJH@mail.gmail.com>
	<4C65E660.9030707@gmail.com>
	<AANLkTi=y-j=2_uX8c2cBR+fpouAaOGu032tT9UCnf8C2@mail.gmail.com>
	<AANLkTi=By2s0YyecQX1V8NXZWBxELtpgCrqJrTiHC+=W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	kusmabite@gmail.com
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 19:39:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkhBT-0004dZ-Ru
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 19:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406Ab0HORjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 13:39:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61348 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab0HORjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 13:39:42 -0400
Received: by ewy23 with SMTP id 23so2003905ewy.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m2l1pij981aOztWNKr4HTaj2jgHm24c9m6vl7bFnLLI=;
        b=XANF+vHuPyLgd0F77ulgP8rcTlrxUcGExDDV5bgqLhmprTizY/1lO8r/JgU72tYUE5
         3em4T0XwQLPhPrTIm2fxMtdN4WOLBiWcVMSBFrmj0k5EeNdJKNLCuUkoB8LuOBsPLS4p
         i/WNpVuUd2uBoPdb+sz+KdpA9WqBYjlDiUCEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N6ara/DW/sbPQRQ7dkh9hUJsnyJYdO7oM/AqgLaKujYiY4lz1bKBPdHrCY/BvZviiz
         791PVv39fRQDrVmJKWojHqqtqz+Oh1GJtT4pqGMYg7PIiOY0s3XS5W+lly1jUHk3TbWL
         +KDV9zfMkXff0+x7ckcEDt1lAyDfSnSGkHiNQ=
Received: by 10.213.10.147 with SMTP id p19mr3946045ebp.66.1281893980595; Sun,
 15 Aug 2010 10:39:40 -0700 (PDT)
Received: by 10.213.22.134 with HTTP; Sun, 15 Aug 2010 10:39:40 -0700 (PDT)
In-Reply-To: <AANLkTi=By2s0YyecQX1V8NXZWBxELtpgCrqJrTiHC+=W@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153614>

On Sun, Aug 15, 2010 at 9:08 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> Thanks, there's a bunch of failures though. Do those usually fail on
> your Cygwin setup? I haven't looked at them in any detail.

Sorry, can't tell you much, as this is absolutely the first time I'm
running *all* the tests. Usually, I only run those that are likely to
be affected by the parts I hack.

--=20
Cheers,
Ray Chuan
