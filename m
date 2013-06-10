From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sun, 9 Jun 2013 23:56:44 -0500
Message-ID: <CAMP44s04L3NB0_D4Mn9uK_SVhv38AN-bN4XMhz7zDw4LEZjbYQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
	<CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
	<alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
	<CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
	<7vd2ryueuu.fsf@alter.siamese.dyndns.org>
	<CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
	<CALkWK0m4V4KYyKW8KJMRsCgOxqcLi0XDYZvS4w++6BKVVvioyw@mail.gmail.com>
	<alpine.DEB.1.00.1306090456160.28957@s15462909.onlinehome-server.info>
	<CALkWK0nCe-fDVdYjD=0XrW-MXBrP1aMrcwdmxfZ_bnM+_esuhQ@mail.gmail.com>
	<7vli6in9ru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Lang <david@lang.hm>, Greg Troxel <gdt@ir.bbn.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 06:57:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UluAE-00059j-85
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 06:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab3FJE4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 00:56:48 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:48602 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab3FJE4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 00:56:47 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so5775508lbh.7
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 21:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mjfBtRfj1pAM1641DgOZ0Ier1BQTGJRZbbVuZ2L7gKU=;
        b=ylMqKeJ1LJAKO8VdYC2UlF4yOIfdN2tQCww4O2xdi5x47VnP4GKlwZhGz9/kedaiQ6
         1YQkHH62IqFknBeyKsbsDqz/n2J1JFWvDyQEo+otDz3v+d37th/lcchXJTw1AD/7GXun
         xxinO7AYGiyEl7CyhELPe+xa3cSUJpnSuAMYkoA136MZKJtb4fuicdFiaUiV+imxk+0F
         l/kyzHF8SHp7dcNQu2z0D9/M6CjjLwEyLGx481cMJHF1UrtF4IMD/VfJvgWVBJBzfcoD
         xNH/A7IKiHpeNDsLkyAfKbpZaTFBoJQpZyalbpTNvRQHZXEffs7mz1Ui1z05FHc8Osv3
         rLvQ==
X-Received: by 10.112.156.5 with SMTP id wa5mr5657648lbb.63.1370840204819;
 Sun, 09 Jun 2013 21:56:44 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 21:56:44 -0700 (PDT)
In-Reply-To: <7vli6in9ru.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227232>

On Sun, Jun 9, 2013 at 6:29 PM, Junio C Hamano <gitster@pobox.com> wrote:

> When otherwise silent old-timers feel a need to come during a
> discussion that might affect the course of the project in a major
> way, we should pay more attention, not less, to what they say (I am
> not saying "we should blindly follow").

I say we should pay attention to the arguments, not the people, that's
ad hominem.

-- 
Felipe Contreras
