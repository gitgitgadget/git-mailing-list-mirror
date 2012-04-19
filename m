From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Thu, 19 Apr 2012 22:38:32 +0200
Message-ID: <vpqaa27bgon.fsf@bauges.imag.fr>
References: <vpqwr5uceis.fsf@bauges.imag.fr>
	<20120406071520.GD25301@sigill.intra.peff.net>
	<vpqr4w12tjj.fsf@bauges.imag.fr>
	<20120406080004.GA27940@sigill.intra.peff.net>
	<4F7FF19B.1060407@alum.mit.edu>
	<20120407075150.GA18168@sigill.intra.peff.net>
	<7viphaygsg.fsf@alter.siamese.dyndns.org>
	<vpq62d6dyzr.fsf@bauges.imag.fr>
	<20120412075535.GC31122@sigill.intra.peff.net>
	<vpqhawp2wxs.fsf@bauges.imag.fr>
	<20120412081407.GE31122@sigill.intra.peff.net>
	<vpqfwc9wckl.fsf@bauges.imag.fr>
	<7vpqbdeyfh.fsf@alter.siamese.dyndns.org>
	<xmqqzka7so2p.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 22:39:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKy8q-0003tG-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 22:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550Ab2DSUjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 16:39:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48001 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932523Ab2DSUjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 16:39:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3JKWQdt019680
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Apr 2012 22:32:26 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SKy7d-0000o4-12; Thu, 19 Apr 2012 22:38:33 +0200
In-Reply-To: <xmqqzka7so2p.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 19 Apr 2012 09:06:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 19 Apr 2012 22:32:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3JKWQdt019680
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335472350.8187@tG58UjT3NXODNKkZpSPGGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195968>

Junio C Hamano <gitster@pobox.com> writes:

> So what happened to this discussion?  

I've been busy, so did nothing, and my procrastination didn't pay ;-).

> Does anybody want to roll the "simple" default based on Peff's patch?

I was about to, actually. I'll go for Peff's semantics at least for now,
and just add tests.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
