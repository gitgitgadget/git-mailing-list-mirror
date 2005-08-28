From: James Cloos <cloos@jhcloos.com>
Subject: Re: SVN import issue
Date: Sun, 28 Aug 2005 01:11:47 -0400
Message-ID: <m3fysuodbg.fsf@lugabout.cloos.reno.nv.us>
References: <pan.2005.08.26.10.40.38.616149@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 28 07:17:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9FY2-0001cw-1c
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 07:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVH1FRD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 01:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVH1FRD
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 01:17:03 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:45572 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1751097AbVH1FRB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2005 01:17:01 -0400
Received: from lugabout.jhcloos.org (host-69-48-12-73.roc.choiceone.net [69.48.12.73])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP id 49B321C5EE
	for <git@vger.kernel.org>; Sun, 28 Aug 2005 00:15:55 -0500 (CDT)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 420CC28F65A; Sun, 28 Aug 2005 05:11:48 +0000 (GMT)
To: git@vger.kernel.org
In-Reply-To: <pan.2005.08.26.10.40.38.616149@smurf.noris.de> (Matthias Urlichs's message of "Fri, 26 Aug 2005 12:40:44 +0200")
X-Hashcash: 1:21:050828:git@vger.kernel.org::FN6bIpx3W9VnLr7m:00000000000000000000000000000000000000000022R6
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7861>

>>>>> "Matthias" == Matthias Urlichs <smurf@smurf.noris.de> writes:

Matthias> Paths in SVN are usually prefixed "/trunk/" (main branch) or
Matthias> "/branches/foo/" (branch foo); tagging is done by creating
Matthias> "/tags/bar", with the trunk (or branch) revision it is
Matthias> pointing to as its parent.

Anyone working on this should note that /usually/ is vital above.

Among other variations, using branch rather than branches is common.

-JimC
