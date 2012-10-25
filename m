From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] fix 'make test' for HP NonStop
Date: Thu, 25 Oct 2012 12:59:14 +0200
Message-ID: <003201cdb29f$c5bc7960$51356c20$@schmitz-digital.de>
References: <001e01cdb061$c25f6380$471e2a80$@schmitz-digital.de> <20121025095826.GM8390@sigill.intra.peff.net> <002e01cdb29a$893593f0$9ba0bbd0$@schmitz-digital.de> <20121025104900.GA6363@sigill.intra.peff.net> <002f01cdb29e$c2db47e0$4891d7a0$@schmitz-digital.de> <20121025105236.GA2962@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:59:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRLA3-0006yf-Eq
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 12:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937Ab2JYK7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 06:59:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:57467 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757745Ab2JYK7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 06:59:23 -0400
Received: from DualCore (dsdf-4db53cfd.pool.mediaWays.net [77.181.60.253])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MZfTi-1TiS4F42l4-00LwN7; Thu, 25 Oct 2012 12:59:22 +0200
In-Reply-To: <20121025105236.GA2962@sigill.intra.peff.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQI2sQMOQ5ANofWD9kSBDc7fafINHQKHXgBmASq388ECc588sgH/DfRWApIX5gOWoiZrcA==
Content-Language: de
X-Provags-ID: V02:K0:kvi3Z40XstU5RslQT83mbmjyI8hNERT1XFK/yzQpU8w
 YaU2oEW7M570+Yyt3HFT00GnRk+1t/eKqvKi0LhDjjuy+mDqIa
 t1MqIksLHO0ga91dwttcdpTIK5Ujol58MsUJ/3CV3iF/K7T9u1
 jAvQKtTNa/JirGzXbhTc0yzgy5jtOZmlDKtNWGbSfIvAN/7whU
 VjKN1LeqJwCERsXivIOJ8gqzqLYIx+jYtgrv0/TwgO6pxeXiPa
 mVvWNLXXywlUtx4RlGz2JAvbqR8Ve/SZ6aiZ9yYAMnl6Cszrwe
 GWUOowDHK6Zl/vard3KUrqwqfWi6bHWs2ziEBJ3Y6ZA6orsFpT
 oZpZOqQ49KDSZ13os+LV/Q1k9qBgkdFrsMSHnpFT4XYYwfi9VG
 T3ORBfsfljA0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208390>

> From: Jeff King [mailto:peff@peff.net]
> Sent: Thursday, October 25, 2012 12:53 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] fix 'make test' for HP NonStop
> 
> On Thu, Oct 25, 2012 at 12:51:59PM +0200, Joachim Schmitz wrote:
> 
> > > But then I would think using /usr/local would be the sane thing to put
> > > there, if that is the closest to "standard" for your platform.
> >
> > OK, yes, hardcoding /usr/local seems OK too.
> > Would I need to re-roll?
> 
> Please do.

Done. For some reason not 'chained' to this thread though

Bye, Jojo
