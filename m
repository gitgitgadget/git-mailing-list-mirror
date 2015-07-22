From: =?iso-8859-1?Q?Zo=EB_Blade?= <zoe@bytenoise.co.uk>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Wed, 22 Jul 2015 17:31:31 +0100
Message-ID: <FCF96FC6-2DCB-42F2-9B75-A97F84ED2D94@bytenoise.co.uk>
References: <1437484966-664-1-git-send-email-zoe@bytenoise.co.uk> <xmqqk2ttuwyy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 18:31:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHwvn-000168-Vx
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 18:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965395AbbGVQbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2015 12:31:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60487 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965154AbbGVQbi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2015 12:31:38 -0400
Received: from [192.168.0.26] ([82.69.105.163]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0MP0FD-1ZKREo29fL-006LVV; Wed, 22 Jul
 2015 18:31:33 +0200
In-Reply-To: <xmqqk2ttuwyy.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V03:K0:HqC76yOJjCZ0kBOjxr0BE2Vv6fnIg5bTkJ0ZYu4l938xeQa0ssS
 YeA8VwHCG/a9w41CgYJRSCElwJvGr5HJYWd/ekNTEaQ0Dq4UOYqs/6jfPQf2STroqTCviJk
 CLF6mfCzah8DKHeNXpCgRz7yIZ+DzvvhozNhXW09QDg0DoT0J3b9QbIVEUWxZ8dXgVRkbxT
 s42bqJ0texmh2IANSbWRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fl3r/KGNSUE=:SJl+diwP6g3VR4VBswLIFb
 6LoR3paRXrqB+pmHbDysTyrhZqr4bK1ooUgjzH6zCiyCiYL6ty/+qYGV9N402LWvqObm2etQB
 Jk/YHTD//01Q6EAysbEmqnTAFnZ0fGJAXcXQ0GCDYHnuu/OgRT7y9cwPpoAx3QHCUA23uvxai
 xRQtnva4h2YA5e/k4aoV7Y7GVw/I0vq5StdcK/XBD2lo/BYgdG3IvGNmaTjAB3FK/QQcXLUP3
 //95sc1BswQntmyEFG9MccCQ1L+nJJqrt3a4ODlZJAFiSTMjMcoAV0GsWmnpEfkp4LtvYjk2j
 hONS8li4wzeAzJdY3lVfcyTaWhXlyVVOh1QcsXg2WGhq0+OuhiX0cgREg0CyE/gIRl485fA2p
 aHwh242MrqW3zqukDykcbpnrrSeS78VjuRPF2xCtjbASN2fDpPzri2v+bqtqnZfoAHZPl4TZu
 jslPKnIOQrdmONBlX2td1WglVCsl7h0iNfsMTsqZP5S6XwyJOHxzKOBal+XoAAiRZ9tc28PHR
 xsqZEypghZfVtMNMpp58jVsfPm74Nwr7MPkpCTtJrVZBLDT9hsoto0REBYbJeGLDvGCb/zpFO
 lAEnTvZ45+J6ig1EfQbK3ldqRImXgmeG2KfK/HbdxPZ1sxMan/VacS7eUa7n50Kq62O64ZH7m
 xVNQSx++TdVPTvF2+ri1zc6uThym8NFoaPZClHGmmB5djKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274446>

Hi again Junio!

Yes, your more elegant and accurate regex sounds much better than the w=
ay I was trying it. :)  Please, go ahead and use yours instead.  Thank =
you for your help!

Thanks,
Zo=EB.