From: Jeff King <peff@peff.net>
Subject: Re: Cyellow, was Re: [a way-too-long line]
Date: Sat, 17 Jan 2009 10:40:52 -0500
Message-ID: <20090117154052.GC27071@coredump.intra.peff.net>
References: <2faad3050901160706y297a98d4r35340e4811ca3d2b@mail.gmail.com> <20090117014057.GA15331@coredump.intra.peff.net> <200901171337.49938.markus.heidelberg@web.de> <20090117152108.GA24899@coredump.intra.peff.net> <alpine.DEB.1.00.0901171638250.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Baz <brian.ewins@gmail.com>,
	Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:42:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODJT-0000E7-BF
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760684AbZAQPk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760798AbZAQPkz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:40:55 -0500
Received: from peff.net ([208.65.91.99]:45507 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760487AbZAQPkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:40:55 -0500
Received: (qmail 31739 invoked by uid 107); 17 Jan 2009 15:40:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Jan 2009 10:40:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Jan 2009 10:40:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901171638250.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106065>

On Sat, Jan 17, 2009 at 04:39:10PM +0100, Johannes Schindelin wrote:

> > True. I was going to suggest %Cyellow, but for some reason only red, 
> > green, and blue are implemented. How silly. Patch series to follow.
> 
> http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=af6ee188b3533e9c8eb665066ed0be32d58be875

:) Yes, that does work, but please see the series I just posted:

  http://article.gmane.org/gmane.comp.version-control.git/106062

which I think is a better solution.

-Peff
