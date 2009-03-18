From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: fetch and pull
Date: Wed, 18 Mar 2009 16:31:20 +0100
Message-ID: <20090318153120.GC8118@atjola.homenet>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com> <76718490903161514ubbdc948o1a0251212fe65fea@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF0A9@EXCHANGE.trad.tradestation.com> <76718490903161709v6d8d09f6k17d2fe1a5e56fb03@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF22F@EXCHANGE.trad.tradestation.com> <76718490903170921r36843c11y5aac537d53384298@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A3FC0A5@EXCHANGE.trad.tradestation.com> <20090318063103.6117@nanako3.lavabit.com> <20090318085849.GA8118@atjola.homenet> <450196A1AAAE4B42A00A8B27A59278E70A3FC468@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 16:33:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjxlK-0002Oj-CC
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 16:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbZCRPb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZCRPb0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 11:31:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:59660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751339AbZCRPb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 11:31:26 -0400
Received: (qmail invoked by alias); 18 Mar 2009 15:31:22 -0000
Received: from i59F5482F.versanet.de (EHLO atjola.local) [89.245.72.47]
  by mail.gmx.net (mp010) with SMTP; 18 Mar 2009 16:31:22 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+xIJ83sX2xQF0yZnZItg8owRQGrH1Jtr9QlbL2JX
	1PJw8aUbJzwxA3
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A3FC468@EXCHANGE.trad.tradestation.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113620>

On 2009.03.18 11:18:41 -0400, John Dlugosz wrote:
> > 2) I don't think that's a common setup, and it's not a default
> > setup, so that hardly qualifies for "normally".
>=20
> How many users of git on a team have it set up by someone who already
> knows what he's doing? I think bad or broken setups might be more
> common. For example, I didn't have any "fetch" setting under remote
> until I started reading this list and digging in more.

Hm? Both clone and "remote add" setup the fetch line by default. So you
manually adjusted the config to add the remote as just an url alias? I'=
m
not convinced that such manual config changes are "normal" either. At
least you're most likely the first user from which I've heard that he
did that.

Bj=F6rn
