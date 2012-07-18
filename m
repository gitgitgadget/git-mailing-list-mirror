From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 4/4] mw-to-git: use git-credential's URL parser
Date: Wed, 18 Jul 2012 15:06:42 +0200
Message-ID: <vpqmx2xi5gd.fsf@bauges.imag.fr>
References: <20120718120307.GA6399@sigill.intra.peff.net>
	<20120718120656.GD6726@sigill.intra.peff.net>
	<vpqd33tjlzm.fsf@bauges.imag.fr>
	<20120718122848.GB11482@sigill.intra.peff.net>
	<vpq1uk9jldk.fsf@bauges.imag.fr>
	<20120718125741.GA11605@sigill.intra.peff.net>
	<20120718130308.GA11769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 15:06:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTxw-00080f-0c
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 15:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab2GRNGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 09:06:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38740 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab2GRNGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 09:06:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6ID52Yu020697
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2012 15:05:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrTxj-0005WO-Mz; Wed, 18 Jul 2012 15:06:43 +0200
In-Reply-To: <20120718130308.GA11769@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Jul 2012 09:03:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Jul 2012 15:05:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6ID52Yu020697
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343221504.3544@KUTw/dTodRH7YA2m9xlylQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201692>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 18, 2012 at 08:57:41AM -0400, Jeff King wrote:
>
>> So since that is a non-issue, I think the second diff I provided above
>> is a bit nicer.
>
> And here is a replacement patch 4/4.
>
> -- >8 --
> Subject: mw-to-git: use git-credential's URL parser

Perfect, thanks.

(and you've been faster than me about the comment ;-) )

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
