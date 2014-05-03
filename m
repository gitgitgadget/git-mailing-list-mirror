From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Pull is Evil
Date: Sat, 3 May 2014 08:17:17 +0200
Message-ID: <20140503061717.GA19561@inner.h.apk.li>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com> <xmqqoazlqot4.fsf@gitster.dls.corp.google.com> <536106EA.5090204@xiplink.com> <xmqqppjyhnom.fsf@gitster.dls.corp.google.com> <536152D3.5050107@xiplink.com> <xmqqa9b2egcy.fsf@gitster.dls.corp.google.com> <20140502074027.GB6288@inner.h.apk.li> <87wqe4y3e6.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat May 03 08:17:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgTGP-0004Wk-3G
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 08:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbaECGR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 02:17:29 -0400
Received: from continuum.iocl.org ([217.140.74.2]:47255 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbaECGR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 02:17:29 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s436HHS20103;
	Sat, 3 May 2014 08:17:17 +0200
Content-Disposition: inline
In-Reply-To: <87wqe4y3e6.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248019>

On Fri, 02 May 2014 10:46:09 +0000, David Kastrup wrote:
...
> What the gibbins?  I don't even use git pull.

I do, but I watch for the fast-forward message
and undo as appropriate.

> I use git fetch, and then, depending on my needs, I rebase or merge.

I wouldn't mind that, but I have a century of newbies who are used
to having other people's changes appear in their workspace without
any interaction. Teaching them the mainline thing (aka first-parent)
and the commands to properly merge&push is...tricky.

And that goes for every user base, so some improvement would be
greatly appreciated.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
