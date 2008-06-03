From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Maintaining two branches.
Date: Tue, 3 Jun 2008 20:02:13 +0200
Message-ID: <20080603180213.GA5541@leksak.fem-net>
References: <20080603163431.GA1244@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 20:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3aql-0005I9-CY
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 20:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbYFCSCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 14:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbYFCSCS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 14:02:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:55547 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752776AbYFCSCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 14:02:17 -0400
Received: (qmail invoked by alias); 03 Jun 2008 18:02:15 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp046) with SMTP; 03 Jun 2008 20:02:15 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX194bSE/clp4TceFK8PGOJy6lBh4oYjev5zNEGi2gK
	0Cc2p1iZhXAfUG
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K3app-0001T0-Qb; Tue, 03 Jun 2008 20:02:13 +0200
Content-Disposition: inline
In-Reply-To: <20080603163431.GA1244@old.davidb.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83684>

Hi,

> I've tried creating a 'next' branch where I merge each change from local
> and/or external, and this seems to work, but the history gets very
> cluttered with merge commits.

You could cherry-pick commits from local and/or external instead of
merging. See git-cherry-pick(1).

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
