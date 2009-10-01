From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to split repository
Date: Thu, 1 Oct 2009 23:13:40 +0200
Message-ID: <20091001211340.GB26068@raven.wolf.lan>
References: <20091001160335.GA26068@raven.wolf.lan> <c376da900910010949p197aa311l9c91ef711beffdf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 23:20:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtT4S-00014l-U9
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 23:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbZJAVUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 17:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbZJAVUF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 17:20:05 -0400
Received: from quechua.inka.de ([193.197.184.2]:46807 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbZJAVUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 17:20:04 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1MtT4J-00041Y-Vf; Thu, 01 Oct 2009 23:20:08 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id B2BF12CBF0; Thu,  1 Oct 2009 23:13:40 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <c376da900910010949p197aa311l9c91ef711beffdf7@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129411>

On Thu, Oct 01, 2009 at 12:49:03PM -0400, Adam Brewster wrote:
> >
> > Any hints how to get rid of those log entries?
> 
> git-filter-branch accepts a --prune-empty option that does what I
> think you're looking for.

Thanks for your answer, Adam!

Is this a new option? 1.6.0.2 don't seem to have it?
