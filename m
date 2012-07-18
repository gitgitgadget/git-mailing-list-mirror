From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] mw-to-git: use git-credential's URL parser
Date: Wed, 18 Jul 2012 15:05:29 +0200
Message-ID: <vpqtxx5i5ie.fsf@bauges.imag.fr>
References: <20120718120307.GA6399@sigill.intra.peff.net>
	<20120718120656.GD6726@sigill.intra.peff.net>
	<vpqd33tjlzm.fsf@bauges.imag.fr>
	<20120718122848.GB11482@sigill.intra.peff.net>
	<vpq1uk9jldk.fsf@bauges.imag.fr>
	<20120718125741.GA11605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 15:05:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTwn-000612-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 15:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab2GRNFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 09:05:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54651 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab2GRNFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 09:05:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6ID3niE020483
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2012 15:03:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrTwY-0005Ve-OX; Wed, 18 Jul 2012 15:05:30 +0200
In-Reply-To: <20120718125741.GA11605@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Jul 2012 08:57:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Jul 2012 15:03:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6ID3niE020483
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343221434.13654@sbnNBSROs98UJ03CRp0XGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201691>

Jeff King <peff@peff.net> writes:

> So since that is a non-issue, I think the second diff I provided above
> is a bit nicer.

I like this one best too. It just lacks a comment saying why it should
be displayed first ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
