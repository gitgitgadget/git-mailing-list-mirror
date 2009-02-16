From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: send-email sending shallow threads by default
Date: Mon, 16 Feb 2009 08:55:34 +0100
Message-ID: <20090216075534.GA11838@neumann>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
	<20090216000732.GC3503@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 08:57:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYyLx-0007K9-QQ
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 08:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbZBPHzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 02:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZBPHzx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 02:55:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:63164 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbZBPHzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 02:55:52 -0500
Received: from [127.0.1.1] (p5B133E92.dip0.t-ipconnect.de [91.19.62.146])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1LYyKC1nWv-0007YL; Mon, 16 Feb 2009 08:55:37 +0100
Content-Disposition: inline
In-Reply-To: <20090216000732.GC3503@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/eiXWDA6WtBdKcf/nvzCFfVDK0HlVCwiu3bEB
 /fHxG1XmpTkSFOtsIEOn8I40xT1Y7753OATAklCGIM3jFW+YN0
 f8yZEGmikiEZIq+mfXKUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110144>

Hi,

On Sun, Feb 15, 2009 at 07:07:32PM -0500, Jeff King wrote:
> On Sun, Feb 15, 2009 at 03:53:50PM -0800, david@lang.hm wrote:
> > I have mixed feelings about this one, if some messages get delayed =
in =20
> > transit the deep threads still keeps them in order, while the 2-lay=
er =20
> > option doesn't.
>=20
> Is that the case? mutt at least orders by thread, but by rfc822 date
> within a single level of thread. So as long as the date fields (set b=
y
> the sender) are correct, it looks right no matter what order they arr=
ive
> in.
>=20
> Are there common readers that thread but do not order by date?

Gmane.

(e.g. http://thread.gmane.org/gmane.comp.version-control.git/110068)

Regards,
G=E1bor
