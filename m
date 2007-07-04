From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Wed, 04 Jul 2007 14:10:27 +0900
Message-ID: <200707040511.l645BIZE003058@mi1.bluebottle.com>
References: <20070703085906.GA4963@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 07:11:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5x9D-0001Md-0H
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 07:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbXGDFLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 4 Jul 2007 01:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbXGDFLU
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 01:11:20 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:36131 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbXGDFLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 01:11:19 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l645BIZE003058
	for <git@vger.kernel.org>; Tue, 3 Jul 2007 22:11:18 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=eTPZSHlSjCaMuw1/28ruMaGHdH7GniRbMhYnafnMaQfS2S0P62mprAKzfui3/imkI
	xkliiUdtdIbzE6CzdH/2out4LkjSB8vrFgAmLkZhGzRSkxR1hdbdhq6FzcVzYER
Received: from nanako3.mail.bluebottle.com (siraly-gw2.selyeuni.sk.133.111.195.in-addr.arpa [195.111.133.92] (may be forged))
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l645BAwn009363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 22:11:17 -0700
In-Reply-To: <20070703085906.GA4963@lala>
X-Trusted-Delivery: <73d8c828438b2c922bd7d0a87a22cb66>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51571>

Quoting Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de>:

> If I do
>
> 	git cat-file commit $commitid
>
> for a commit created by stash, the next prompt starts directly after =
the
> shortlog of HEAD.

Thank you for fixing my bug.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46ree pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
