From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 02 Dec 2010 18:44:58 +0100
Message-ID: <m262vcqdb9.fsf@igel.home>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
	<1291230820.11917.25.camel@drew-northup.unet.maine.edu>
	<877hftuvvz.fsf@picasso.cante.net>
	<7vfwuhtafr.fsf@alter.siamese.dyndns.org>
	<AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
	<87sjygspgy.fsf@picasso.cante.net>
	<buo39qg8zrf.fsf@dhlpc061.dev.necel.com>
	<87bp54s770.fsf@picasso.cante.net> <87mxoos4a8.fsf@catnip.gol.com>
	<20101202132053.GF6537@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: jari <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 18:45:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODDS-0004Ya-25
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273Ab0LBRpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 12:45:03 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39728 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757171Ab0LBRpC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 12:45:02 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 6AE991C08A4F;
	Thu,  2 Dec 2010 18:44:59 +0100 (CET)
Received: from igel.home (ppp-88-217-120-23.dynamic.mnet-online.de [88.217.120.23])
	by mail.mnet-online.de (Postfix) with ESMTP id 3D2EC1C001DA;
	Thu,  2 Dec 2010 18:44:59 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id DA6D7CA2A0; Thu,  2 Dec 2010 18:44:58 +0100 (CET)
X-Yow: Is this TERMINAL fun?
In-Reply-To: <20101202132053.GF6537@picasso.cante.net> (jari's message of
	"Thu, 2 Dec 2010 15:20:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162715>

jari <jari.aalto@cante.net> writes:

> Not that it matters, but have you happende to notice that all git
> outputs use
>
>     commit~N
>
> notation. Not the
>
>     commit^

Did you try "git show-branch -a" recently?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
