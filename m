From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] completion: support 'git config --local'
Date: Wed, 13 Feb 2013 08:44:34 +0100
Message-ID: <vpqwqucu07x.fsf@grenoble-inp.fr>
References: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
	<1360671642-10272-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vzjz9h1w0.fsf@alter.siamese.dyndns.org>
	<20130212211140.GA29358@sigill.intra.peff.net>
	<7v1uclfafi.fsf@alter.siamese.dyndns.org>
	<20130213000519.GA31758@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dasa Paddock <dpaddock@esri.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 08:45:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5X1x-0007nr-As
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 08:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271Ab3BMHpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 02:45:00 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47598 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756615Ab3BMHo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 02:44:59 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1D7iXQR029362
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Feb 2013 08:44:33 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U5X18-0007oL-G6; Wed, 13 Feb 2013 08:44:34 +0100
In-Reply-To: <20130213000519.GA31758@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Feb 2013 19:05:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Feb 2013 08:44:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1D7iXQR029362
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361346278.75435@TXLtLiMj6w+xfgWsYHRbTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216237>

Jeff King <peff@peff.net> writes:

> So yeah. Matthieu's patch is the right thing to do, as it covers both

Thanks,

> (mine fixed only half of it).

(Sorry, I had missed yours)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
