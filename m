From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 14:23:41 +0200
Message-ID: <m3prnumysy.fsf@maximus.localdomain>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	<1219664940.9583.42.camel@pmac.infradead.org>
	<alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	<20080826145719.GB5046@coredump.intra.peff.net>
	<1219764860.4471.13.camel@gaara.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, users@kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 14:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYK57-0006MY-NB
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 14:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbYH0MX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 08:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbYH0MX4
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 08:23:56 -0400
Received: from khc.piap.pl ([195.187.100.11]:58975 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636AbYH0MXz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 08:23:55 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 173F824BFA; Wed, 27 Aug 2008 14:23:41 +0200 (CEST)
In-Reply-To: <1219764860.4471.13.camel@gaara.bos.redhat.com> ("Kristian
 =?utf-8?Q?H=C3=B8gsberg=22's?= message of "Tue\, 26 Aug 2008 11\:34\:20
 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93887>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> It's pretty normal to see opponents of a decision like this complain
> loudly when it lands on their system, whereas the silent majority in
> favour will be happy to see the change finally implemented but reluct=
ant
> to stir up the discussion again.

I'm "sure" the silent majority don't care at all. Git is a program
mostly for a specialized group of people who are perfectly capable of
using either model or customizing the installation at will.

It may be a correctness issue with pro and cons for each model
(something along the lines of "how many devils..."), but it doesn't
matter for the (I'm sure) "silent majority" in practice at
all. Writing this email (let alone reading them all) takes more time
than customizing git config.
--=20
Krzysztof Halasa
