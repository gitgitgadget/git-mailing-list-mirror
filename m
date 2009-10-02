From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to split repository
Date: Fri, 2 Oct 2009 17:42:04 +0200
Message-ID: <20091002154204.GC26068@raven.wolf.lan>
References: <20091001160335.GA26068@raven.wolf.lan> <c376da900910010949p197aa311l9c91ef711beffdf7@mail.gmail.com> <20091001211340.GB26068@raven.wolf.lan> <c376da900910011747i894404dne1ea60dae5e3990b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 17:50:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtkOm-0004kq-VW
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 17:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbZJBPuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 11:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754315AbZJBPuL
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 11:50:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:56369 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615AbZJBPuK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 11:50:10 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1MtkOb-0001SQ-OI; Fri, 02 Oct 2009 17:50:13 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 064602CBFE; Fri,  2 Oct 2009 17:42:04 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <c376da900910011747i894404dne1ea60dae5e3990b@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129447>

On Thu, Oct 01, 2009 at 08:47:15PM -0400, Adam Brewster wrote:
> >>
> >> git-filter-branch accepts a --prune-empty option that does what I
> >> think you're looking for.
> > Thanks for your answer, Adam!
> > Is this a new option? 1.6.0.2 don't seem to have it?
> 1.6.0.2 was released September 2008 (git log -n1 v1.6.0.2).
> 
> This feature was added in October 2008.  (git blame
> Documentation/git-filter-branch.txt; git log -n1 d3240d93).
> 
> It's still it is missing from the option summary in master though.

Thanks for clarifying that, Adam!
