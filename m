From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: rm and mv commands: should I use them?
Date: Mon, 7 Jan 2008 19:37:38 +0100
Message-ID: <200801071937.38976.robin.rosenberg.lists@dewire.com>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com> <7v63y62xwj.fsf@gitster.siamese.dyndns.org> <20080107030642.GA18194@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Hancock <redstarling@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 07 19:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBwrX-000637-5A
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 19:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688AbYAGShr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2008 13:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbYAGShr
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 13:37:47 -0500
Received: from [83.140.172.130] ([83.140.172.130]:7436 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbYAGShq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 13:37:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 294FA802893;
	Mon,  7 Jan 2008 19:37:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eGfwmM4EYzzi; Mon,  7 Jan 2008 19:37:44 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 5CDF7802641;
	Mon,  7 Jan 2008 19:37:44 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <20080107030642.GA18194@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69798>

m=E5ndagen den 7 januari 2008 skrev Jeff King:
> On Sun, Jan 06, 2008 at 06:05:16PM -0800, Junio C Hamano wrote:
=2E..
> > "git mv" should not have staged the change.  It should have
> > moved the index entry from Makefile to makefile and moved the
> > work tree files.
>=20
> I thought there was some discussion about this a few months ago,
> concerning what exactly it should do, and that was how we arrived at =
the
> current behavior. However, I can't seem to find it now. Maybe I dream=
ed
> it.

I had the same dream.

-- robin
