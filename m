From: Jan Engelhardt <jengelh@medozas.de>
Subject: git push --all not so all (was: Re: [ANNOUNCE] conntrack-tools 0.9.10
 released)
Date: Mon, 26 Jan 2009 21:03:21 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901262102190.25738@fbirervta.pbzchgretzou.qr>
References: <497CD41A.3040106@netfilter.org> <alpine.LSU.2.00.0901260050030.31299@fbirervta.pbzchgretzou.qr> <497E03E7.7030201@netfilter.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Netfilter Developer Mailing List 
	<netfilter-devel@vger.kernel.org>, pablo@netfilter.org
To: git@vger.kernel.org
X-From: netfilter-devel-owner@vger.kernel.org Mon Jan 26 21:05:00 2009
Return-path: <netfilter-devel-owner@vger.kernel.org>
Envelope-to: gnnd-netfilter-devel@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXhN-0007Nv-Dj
	for gnnd-netfilter-devel@gmane.org; Mon, 26 Jan 2009 21:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbZAZUDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gnnd-netfilter-devel@m.gmane.org>);
	Mon, 26 Jan 2009 15:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbZAZUDY
	(ORCPT <rfc822;netfilter-devel-outgoing>);
	Mon, 26 Jan 2009 15:03:24 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:47177 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbZAZUDX (ORCPT
	<rfc822;netfilter-devel@vger.kernel.org>);
	Mon, 26 Jan 2009 15:03:23 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 9B468180638E8; Mon, 26 Jan 2009 21:03:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 95D5E1CC769BB;
	Mon, 26 Jan 2009 21:03:21 +0100 (CET)
In-Reply-To: <497E03E7.7030201@netfilter.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107264>


On Monday 2009-01-26 19:41, Pablo Neira Ayuso wrote:
>Jan Engelhardt wrote:
>> On Sunday 2009-01-25 22:05, Pablo Neira Ayuso wrote:
>>=20
>>> Hi!
>>>
>>> The netfilter project presents another development release of the
>>> conntrack-tools. As usual, this release includes important fixes,
>>> improvements and new features, mainly:
>>=20
>> The git tag for 0.9.10 seems to be missing.
>
>I forgot to add git push --tags to my release scripts, thanks for the
>notice.

I always wonder why `git push --all` does not push everything
(it should be true to its name, really)=C2=A0=E2=80=94 such as tags  o_=
O
--
To unsubscribe from this list: send the line "unsubscribe netfilter-dev=
el" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
