From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: windows smoke tester (was Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Sun, 15 Aug 2010 01:08:50 +0000
Message-ID: <AANLkTi=By2s0YyecQX1V8NXZWBxELtpgCrqJrTiHC+=W@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	kusmabite@gmail.com
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 03:09:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkRio-0003lg-U0
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 03:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614Ab0HOBIw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 21:08:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41614 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756578Ab0HOBIv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 21:08:51 -0400
Received: by iwn7 with SMTP id 7so305536iwn.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 18:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BQrflSs2C4aU9JzhYcSPh4m9Z59lKVCt/1VI3Z6TwL8=;
        b=FHCD1AvedknN3czLbEZlmZN6hX3rGUmCMJd+q8gpAQh2EPoLwuPXsYS8UYqATwlKaJ
         krN+lSqlDMlN+D0X59+6fEiTcv8UGMmp27w+OHw5ZXeKzCMeyYffAZj9I2g0MwsZ7Ali
         aycxNmzU4nl8GNr/ozKyuB8oT1pdyWWbLEAg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MD8mn4Z6Pd/xAO59KtVVLNGyOGTmKFITISVwnplc/nYY9WrdobZYnmWN02+HXk8+zi
         59NRoBXqi1IzSnMUVvO1Tc9RFGHPio4r2eRYEJ0KnwaKstcX4NorrVXNTAqK+Pi7x4vl
         Agbtu3qjXEOF8WLgTzjP+sj1mpq5mHMtbzIaY=
Received: by 10.231.40.9 with SMTP id i9mr3706240ibe.5.1281834530918; Sat, 14
 Aug 2010 18:08:50 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 18:08:50 -0700 (PDT)
In-Reply-To: <AANLkTi=y-j=2_uX8c2cBR+fpouAaOGu032tT9UCnf8C2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153589>

On Sun, Aug 15, 2010 at 00:54, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Sat, Aug 14, 2010 at 8:42 AM, Chris Packham <judge.packham@gmail.c=
om> wrote:
>> I couldn't install any perl modules with the environment provided by
>> msysgit, I couldn't make msys play nice with strawberry perl. In
>> desperation I tried cygwin
>> [snip]
>
> I've tried it out on cygwin, check out report #30:
>
> =C2=A0http://smoke.git.nix.is/app/projects/report_details/30
>
> A lot of stuff was skipped though - python, http.

Thanks, there's a bunch of failures though. Do those usually fail on
your Cygwin setup? I haven't looked at them in any detail.
