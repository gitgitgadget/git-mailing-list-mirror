From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] log: use true parents for diff when walking reflogs
Date: Sat, 3 Aug 2013 12:40:07 +0200
Message-ID: <87mwoz6os8.fsf@hexa.v.cablecom.net>
References: <d6dadc4ab54d81490ca46bcfbd44a61be24f6eb7.1375524982.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 03 12:40:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5ZFw-00074I-SO
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 12:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab3HCKkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 06:40:10 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:56796 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab3HCKkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 06:40:09 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 12:39:57 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 12:40:07 +0200
In-Reply-To: <d6dadc4ab54d81490ca46bcfbd44a61be24f6eb7.1375524982.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Sat, 3 Aug 2013 12:36:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231577>

Doh, once again I forgot the in-reply-to.  This patch continues the
thread after <20130731225520.GB25882@sigill.intra.peff.net>.  This is --
strangely enough -- missing from gmane; its immediate predecessor is
this:

  http://thread.gmane.org/gmane.comp.version-control.git/230968/focus=231453

Sorry for the noise.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
