From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: windows smoke tester (was Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Sun, 15 Aug 2010 08:54:22 +0800
Message-ID: <AANLkTi=y-j=2_uX8c2cBR+fpouAaOGu032tT9UCnf8C2@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	kusmabite@gmail.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 02:54:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkRUn-0000E1-O3
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 02:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757608Ab0HOAyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 20:54:24 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34480 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756578Ab0HOAyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 20:54:23 -0400
Received: by ewy23 with SMTP id 23so1854935ewy.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=wia/eBjHvNjWLqUa09C5tvrq3n3QXRZOS/MXV9GcFvA=;
        b=VbTLwdn880ewtnpuMzZYeZhjZoXftpVDz2mojGdhC61pDdLoPb36rAciEzkxw1Dbnt
         g2kMPFuA0VBIq5BAHcipqlGatF7K3fex3jR1lAy2VeAs03xJlw8zhNWghucz83wT9ZWR
         wbSs8Ca+K8271res1uwuckD9bLhttJItE/4zA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xfBiDeFYww4cFppNR/B7ouNeqI7xOnxXUmF4k2XQ8Mej/9yImRQ0aGvBeM4+7/G7+Y
         xPBBF/CDoj70FjsvyqrVbuKwydQWdgAxOL/QNaOlU7FHj5LlbvTJkzYWzyEc5Waj/hUM
         YOyOJUbJEECqfhSY1A1lKqtL7DMtrn8uQ+X/w=
Received: by 10.213.12.196 with SMTP id y4mr3004182eby.89.1281833662127; Sat,
 14 Aug 2010 17:54:22 -0700 (PDT)
Received: by 10.213.32.76 with HTTP; Sat, 14 Aug 2010 17:54:22 -0700 (PDT)
In-Reply-To: <4C65E660.9030707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153588>

Hi,

On Sat, Aug 14, 2010 at 8:42 AM, Chris Packham <judge.packham@gmail.com> wrote:
> I couldn't install any perl modules with the environment provided by
> msysgit, I couldn't make msys play nice with strawberry perl. In
> desperation I tried cygwin
> [snip]

I've tried it out on cygwin, check out report #30:

  http://smoke.git.nix.is/app/projects/report_details/30

A lot of stuff was skipped though - python, http.

-- 
Cheers,
Ray Chuan
