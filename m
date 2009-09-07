From: Jeff King <peff@peff.net>
Subject: Re: tracking branch for a rebase
Date: Mon, 7 Sep 2009 04:44:55 -0400
Message-ID: <20090907084455.GC17997@coredump.intra.peff.net>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net>
 <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
 <4AA4C0CE.2070300@drmicha.warpmail.net>
 <7vzl97xit9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:45:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZqT-0000D2-QF
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbZIGIo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZIGIo4
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:44:56 -0400
Received: from peff.net ([208.65.91.99]:45281 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbZIGIo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:44:56 -0400
Received: (qmail 15825 invoked by uid 107); 7 Sep 2009 08:45:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Sep 2009 04:45:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Sep 2009 04:44:55 -0400
Content-Disposition: inline
In-Reply-To: <7vzl97xit9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127907>

On Mon, Sep 07, 2009 at 01:25:38AM -0700, Junio C Hamano wrote:

> > @{^}
> 
> This _could_ work, although it is rather cryptic.

But an identifier composed entirely of punctuation? It might help git
catch on with perl programmers. ;)

-Peff
