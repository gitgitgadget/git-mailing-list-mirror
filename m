From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/4] Rename push.default to push.mode
Date: Tue, 31 Mar 2009 09:08:13 -0400
Message-ID: <20090331130813.GA8148@coredump.intra.peff.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net> <1238407903-28020-5-git-send-email-santi@agolina.net> <49D0A1FE.60300@drmicha.warpmail.net> <adf1fd3d0903300537i41d4aef3g49ab6bde9343cbc5@mail.gmail.com> <49D0C3B8.2050801@drmicha.warpmail.net> <20090330134544.GA31827@coredump.intra.peff.net> <49D0DB78.2010204@drmicha.warpmail.net> <20090330180253.GA7220@coredump.intra.peff.net> <49D212B0.8070005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 15:10:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lodjm-0001HC-5z
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 15:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979AbZCaNI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 09:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758061AbZCaNI0
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 09:08:26 -0400
Received: from peff.net ([208.65.91.99]:47871 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758200AbZCaNIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 09:08:25 -0400
Received: (qmail 10183 invoked by uid 107); 31 Mar 2009 13:08:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 09:08:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 09:08:13 -0400
Content-Disposition: inline
In-Reply-To: <49D212B0.8070005@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115259>

On Tue, Mar 31, 2009 at 02:55:12PM +0200, Michael J Gruber wrote:

> I haven't seen any breakage. I just noticed a different font being used
> for Santi's posts (due to different character encoding, with a different
> font preset in TB) and looked at the message source, where I saw =20 and
> such all over the place (message display is fine). When saving from TB
> the QP is undone. It just made me feel uneasy because of our recent
> discussion regarding format-flowed and patch submission. I know ff \ne
> qp, but still I thought git-{send-email,apply} would prefer straight ascii.

Ah, OK. I think everything is working as expected, then. Thanks for the
clarification.

-Peff
