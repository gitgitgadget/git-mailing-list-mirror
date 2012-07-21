From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Fix git-svn tests for SVN 1.7.5.
Date: Fri, 20 Jul 2012 20:27:57 -0400
Message-ID: <1342830380-sup-1776@pinkfloyd.chass.utoronto.ca>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
	gitster <gitster@pobox.com>, robbat2 <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 02:28:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsNYc-0006Ge-I3
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 02:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab2GUA2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 20:28:24 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:42560 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab2GUA2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 20:28:04 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:39426 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SsNY6-0008FI-1n; Fri, 20 Jul 2012 20:27:58 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SsNY6-0005aE-0e; Fri, 20 Jul 2012 20:27:58 -0400
In-reply-to: <20120717174446.GA14244@burratino>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201798>


Hi Michael,

> > I've fixed the git-svn tests for SVN 1.7 and tested with SVN 1.7.5.
> 
> Thanks.  git-svn is not maintained by Junio but by Eric and others on
> the list.  I'm cc-ing Eric and Ben Walton so they can benefit from
> your work.

This is fantastic.  It's been on my todo list but not a priority for
me.  I'm glad you've taken the time to scratch this itch though.

I'll try to run through this series in the next few days and I can
also do some test builds on solaris to see how it plays there.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
