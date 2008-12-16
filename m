From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-daemon documentation: use {tilde}
Date: Tue, 16 Dec 2008 18:38:57 +0100
Message-ID: <4947E7B1.2090608@drmicha.warpmail.net>
References: <1229442492-11993-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Dec 16 18:40:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCduB-0001j7-Bn
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 18:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbYLPRjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 12:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbYLPRjE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 12:39:04 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45525 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751957AbYLPRjD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Dec 2008 12:39:03 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 55D751E78BC;
	Tue, 16 Dec 2008 12:39:01 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 16 Dec 2008 12:39:01 -0500
X-Sasl-enc: cva9JpF0TVzxh+Kxjfr/m50CzoXyztaZjs82NHtxw2T3 1229449140
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 988572B9EE;
	Tue, 16 Dec 2008 12:39:00 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <1229442492-11993-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103285>

Miklos Vajna venit, vidit, dixit 16.12.2008 16:48:
> Use '{tilde}' instead of '~', becase the later does not appear in the
> manpage version, just in the HTML one.

Curiously, "git help daemon" (which execs "man git-daemon") displays the
tilde but "man git-daemon" does not (nor does "konqueror
man:git-daemon"). Humh?

Michael
