From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it
	for locating test files
Date: Thu, 4 Sep 2008 11:23:11 +0200
Message-ID: <20080904092311.GA25735@diku.dk>
References: <20080903091022.GC23406@diku.dk> <20080903170904.GB28315@spearce.org> <9e85b2570809031847r34a760ecwea365930327eb205@mail.gmail.com> <20080904032118.GA3262@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imran M Yousuf <imran@smartitengineering.com>,
	Imran M Yousuf <imyousuf@smartitengineering.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 11:24:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbB4h-0005uF-BO
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbYIDJXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYIDJXP
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:23:15 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:44234 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbYIDJXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:23:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 9465252C394;
	Thu,  4 Sep 2008 11:23:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w7+Z5wr+Hac7; Thu,  4 Sep 2008 11:23:11 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 58F9152C334;
	Thu,  4 Sep 2008 11:23:11 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 156F66DF84F; Thu,  4 Sep 2008 11:23:10 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 3E5621DE5F4; Thu,  4 Sep 2008 11:23:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080904032118.GA3262@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94914>

Shawn O. Pearce <spearce@spearce.org> wrote Wed, Sep 03, 2008:
> Imran M Yousuf <imran@smartitengineering.com> wrote:
> > Almighty willing, I will submit my patches this weekend (on Saturday).
> > I develop in NetBeans so that would make it easier for sure.

Perfect. You might be interested in the hopefully soon to be released
jgit-based nbgit module:

 - http://nbgit.googlecode.com/

The feature set is limited but some of the basics features should be
there.

> Awesome.  Then I'll hold off on Jonas' patch for now.

Super.

-- 
Jonas Fonseca
