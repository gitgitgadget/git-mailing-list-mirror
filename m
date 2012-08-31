From: <dag@cray.com>
Subject: Re: (minor concern) git using the pager should not be a default
Date: Fri, 31 Aug 2012 18:03:17 -0500
Message-ID: <nngd3267jgq.fsf@transit.us.cray.com>
References: <503E3CFE.1080603@sigmadesigns.com>
	<7vd329wpt0.fsf@alter.siamese.dyndns.org>
	<nngligvdk0q.fsf@transit.us.cray.com> <m2a9xblyqp.fsf@igel.home>
	<20120831214312.GB3008@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emmanuel Michon <emmanuel_michon@sigmadesigns.com>,
	<git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 01:14:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7aQI-0004PR-BE
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 01:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190Ab2HaXOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 19:14:38 -0400
Received: from exprod6og102.obsmtp.com ([64.18.1.183]:56746 "EHLO
	exprod6og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091Ab2HaXOi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 19:14:38 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob102.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUEFFWOqe3OxOi7Rxj7o0vSBdg+7kv4ss@postini.com; Fri, 31 Aug 2012 16:14:37 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Fri, 31 Aug
 2012 18:03:18 -0500
In-Reply-To: <20120831214312.GB3008@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 31 Aug 2012 17:43:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204613>

Jeff King <peff@peff.net> writes:

> if you really want it. As of 9bad723 (allow command-specific pagers in
> pager.<cmd>, 2010-11-17), you can even set it to an arbitrary pager for
> each git command.

Cool!

> With all those options, it's amazing that we can still have threads
> about what should page. :)

Well to be fair, it's hard to know when to read the documentation again.
:)

                               -Dave
