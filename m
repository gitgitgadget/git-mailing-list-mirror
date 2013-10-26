From: Thomas Rast <tr@thomasrast.ch>
Subject: Improving git-scm.com/community [Re: git 1.8.4.1 configure should ship TYPE_SOCKLEN_T source macro]
Date: Sat, 26 Oct 2013 11:22:07 +0200
Message-ID: <8738nopetc.fsf@linux-k42r.v.cablecom.net>
References: <alpine.SOC.2.11.1310251814410.29200@dogbert.cc.ndsu.NoDak.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tim Mooney <Tim.Mooney@ndsu.edu>
X-From: git-owner@vger.kernel.org Sat Oct 26 11:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va04n-0000DS-Hc
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 11:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167Ab3JZJWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 05:22:20 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50426 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab3JZJWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 05:22:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id CB35E4D6514;
	Sat, 26 Oct 2013 11:22:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zjH2hB8D73oQ; Sat, 26 Oct 2013 11:22:08 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (84-73-49-17.dclient.hispeed.ch [84.73.49.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 0CB854D6414;
	Sat, 26 Oct 2013 11:22:07 +0200 (CEST)
In-Reply-To: <alpine.SOC.2.11.1310251814410.29200@dogbert.cc.ndsu.NoDak.edu>
	(Tim Mooney's message of "Fri, 25 Oct 2013 18:26:39 -0500 (CDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236745>

Tim Mooney <Tim.Mooney@ndsu.edu> writes:

> [git-scm.com/community doesn't say whether the address for bug reports
> allows posting by non-list members, so hopefully this makes it through
> the moderation process]

The text is here:

  https://github.com/github/gitscm-next

So we can actively improve such things.  I just sent this pull request:

  https://github.com/github/gitscm-next/pull/318

-- 
Thomas Rast
tr@thomasrast.ch
