From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] send-email: correct two tests which were going
	interactive
Date: Tue, 31 Mar 2009 15:46:06 -0400
Message-ID: <20090331194606.GA23184@coredump.intra.peff.net>
References: <cover.1238516122.git.jaysoffian@gmail.com> <232681e20e15a61defb73a1645fd2c6b6aadd751.1238516122.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 21:48:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lojw9-0001Yd-W3
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 21:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbZCaTqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 15:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbZCaTqT
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 15:46:19 -0400
Received: from peff.net ([208.65.91.99]:48550 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbZCaTqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 15:46:18 -0400
Received: (qmail 12527 invoked by uid 107); 31 Mar 2009 19:46:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 15:46:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 15:46:06 -0400
Content-Disposition: inline
In-Reply-To: <232681e20e15a61defb73a1645fd2c6b6aadd751.1238516122.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115303>

On Tue, Mar 31, 2009 at 12:22:13PM -0400, Jay Soffian wrote:

> Commit 67f1fe5 added two tests which went interactive under the
> dash shell. This commit corrects the issue. Reported by
> Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>

Thanks. I was seeing the same issue as Bj=C3=B6rn, and this fixes it fo=
r me.

-Peff
