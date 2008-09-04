From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it
	for locating test files
Date: Thu, 4 Sep 2008 13:17:52 +0200
Message-ID: <20080904111752.GA27590@diku.dk>
References: <20080903091022.GC23406@diku.dk> <20080903170904.GB28315@spearce.org> <9e85b2570809031847r34a760ecwea365930327eb205@mail.gmail.com> <20080904032118.GA3262@spearce.org> <20080904092311.GA25735@diku.dk> <m3prnkp4qq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Imran M Yousuf <imran@smartitengineering.com>,
	Imran M Yousuf <imyousuf@smartitengineering.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 13:19:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbCrf-0008AU-Ne
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 13:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbYIDLR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 07:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbYIDLR4
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 07:17:56 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:45040 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbYIDLRz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 07:17:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8CFE952C3D8;
	Thu,  4 Sep 2008 13:17:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ppAP7XlF6WKi; Thu,  4 Sep 2008 13:17:52 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5E49352C3A8;
	Thu,  4 Sep 2008 13:17:52 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id EF5776DF835; Thu,  4 Sep 2008 13:17:50 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 4455A1DE5F8; Thu,  4 Sep 2008 13:17:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3prnkp4qq.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94926>

Jakub Narebski <jnareb@gmail.com> wrote Thu, Sep 04, 2008:
> Could you please add it to Git Wiki
>   http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
> when it is ready, at least for testing purposes?

Of course. There is already a NetbeansPlugin page but it doesn't look
like it was integrated into the tools list.

-- 
Jonas Fonseca
