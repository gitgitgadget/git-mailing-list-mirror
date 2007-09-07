From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 13:30:56 +0200
Message-ID: <44DC6433-1BCD-4968-83E6-6631726E0523@wincent.com>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <46E0EEC6.4020004@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Sep 07 13:31:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITc3U-0007mp-3R
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 13:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbXIGLbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 07:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbXIGLbO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 07:31:14 -0400
Received: from wincent.com ([72.3.236.74]:48467 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965180AbXIGLbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 07:31:13 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l87BV22V030978;
	Fri, 7 Sep 2007 06:31:03 -0500
In-Reply-To: <46E0EEC6.4020004@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58027>

El 7/9/2007, a las 8:25, Andreas Ericsson escribi=F3:

> Nono, hand-optimized assembly is the best choice for speed. C is just
> a little more portable ;-)

=46unny thing is, GCC almost certainly produces better-optimized =20
assembly than most programmers could... ;-)

Cheers,
Wincent
