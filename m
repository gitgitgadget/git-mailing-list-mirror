From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Thu, 21 Aug 2008 16:30:30 +0200
Message-ID: <48AD7C06.50501@fastmail.fm>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821134946.GR23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 16:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWBDA-0006dt-Ey
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088AbYHUOap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755711AbYHUOao
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:30:44 -0400
Received: from main.gmane.org ([80.91.229.2]:43628 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756056AbYHUOan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:30:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWBBP-0004Hg-AG
	for git@vger.kernel.org; Thu, 21 Aug 2008 14:30:39 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 14:30:39 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 14:30:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <20080821134946.GR23800@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93156>

Miklos Vajna venit, vidit, dixit 21.08.2008 15:49:
> On Thu, Aug 21, 2008 at 11:19:41AM +0200, Michael J Gruber <michaeljgruber+gmane@fastmail.fm> wrote:
>> If there's interest in this patch I'll follow up with a documentation patch.
> 
> See http://article.gmane.org/gmane.comp.version-control.git/92913.

I've read the post you quote but I'm not sure you've read that AND my
post. I clearly described/documented what my patch does and why I think
it's useful, in the way it's often done here: after the commit message
and before the diffstat. It is documented (as required in the post you
cite), it just doesn't contain a documentation patch.

Documentation/SubmittingPatches in all its length doesn't contain the
requirement you're reading into Junio's post. Maybe it should, if that's
what is meant.

Michael
