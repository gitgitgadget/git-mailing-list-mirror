From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH RFC v2 07/19] rebase -i: The replay of root commits is not shown with --verbose
Date: Tue, 15 Jul 2014 10:29:48 +0100
Message-ID: <C27412B4-3289-4776-974A-4E7B69DA5786@arachsys.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com> <b1ecef042cd18a0251199429e4efb969b085d5fe.1404323078.git.bafain@gmail.com> <53BFEA9C.6010203@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 11:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6zQA-0003ee-C6
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 11:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758412AbaGOJxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 05:53:09 -0400
Received: from cdw.me.uk ([91.203.57.136]:39457 "EHLO cdw.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758106AbaGOJxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 05:53:08 -0400
X-Greylist: delayed 1391 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jul 2014 05:53:07 EDT
Received: from [81.2.114.212] (helo=chris.lan)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1X6z3X-0002jf-P2; Tue, 15 Jul 2014 10:29:52 +0100
In-Reply-To: <53BFEA9C.6010203@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253550>

Fabian Ruch <bafain@gmail.com> wrote:

> you're the original author of the code touched by this patch. Is the
> second -q option really a simple copy-and-paste of the first or am I
> overlooking something here? I'd like to confirm this as, in retrospect,
> I feel a bit uncertain about the hasty claim in the log message.

It was a while ago and I don't remember the details of this patch I'm
afraid, but your rationale here looks sensible to me. I tend to find git too
noisy by default rather than too quiet, so it wouldn't surprise me if I
never thought to try the --verbose version.

Cheers,

Chris.
