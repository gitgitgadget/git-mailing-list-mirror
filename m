From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Sun, 25 Jan 2009 18:20:00 -0500
Message-ID: <20090125231959.GA19099@coredump.intra.peff.net>
References: <831vuvfh7t.fsf@kalahari.s2.org> <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com> <83wscndv57.fsf@kalahari.s2.org> <94a0d4530901240021u65adeff8pb6995ef707bc1f68@mail.gmail.com> <alpine.DEB.1.00.0901241438370.13232@racer> <94a0d4530901240604o5ae0d321h17dc6aabeefe9d53@mail.gmail.com> <7vvds3dszy.fsf@gitster.siamese.dyndns.org> <94a0d4530901251312q4201d51btd806fe860a12afd6@mail.gmail.com> <20090125214435.GA20173@coredump.intra.peff.net> <190FD80D-0F10-4C76-9029-1434F362EFDB@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:21:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREID-0007aO-Rr
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbZAYXUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbZAYXUD
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:20:03 -0500
Received: from peff.net ([208.65.91.99]:60818 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbZAYXUC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:20:02 -0500
Received: (qmail 29074 invoked by uid 107); 25 Jan 2009 23:20:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 18:20:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 18:20:00 -0500
Content-Disposition: inline
In-Reply-To: <190FD80D-0F10-4C76-9029-1434F362EFDB@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107125>

On Sun, Jan 25, 2009 at 11:55:24PM +0100, Wincent Colaiuta wrote:

>> I think there should also be some explanatory text that indicates they
>> are totally interchangeable for the rest of the document. Something
>> like: "When we show configuration in the rest of this document, we will
>> use format X [I think probably "git config $VAR $VALUE"]. But you can
>> use whichever method you are most comfortable with."
>
> I already suggested something similar about 4 days ago:
>
> http://article.gmane.org/gmane.comp.version-control.git/106673/

Oh, I think I must have mixed up reading your post and thinking it was
from Felipe. Sorry.

At any rate, I think what you wrote there is sensible.

-Peff
