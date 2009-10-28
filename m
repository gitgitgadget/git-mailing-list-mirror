From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: drawbacks to svn server + git-svn vs git server?
Date: Wed, 28 Oct 2009 04:53:15 -0700 (PDT)
Message-ID: <26093326.post@talk.nabble.com>
References: <25994334.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 12:53:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N375f-00067A-Lr
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 12:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbZJ1LxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 07:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbZJ1LxL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 07:53:11 -0400
Received: from kuber.nabble.com ([216.139.236.158]:39754 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbZJ1LxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 07:53:10 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N375X-0002pc-Pk
	for git@vger.kernel.org; Wed, 28 Oct 2009 04:53:15 -0700
In-Reply-To: <25994334.post@talk.nabble.com>
X-Nabble-From: timmazid@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131448>


Hi,

I recently migrated from svn to git as well, but I've abandoned the svn
server altogether.
What I noticed is that the merges do not show up properly when you look at
the svn repo with git. Obviously because svn doesn't track that information.
I assume that such a problem would continue if you continued using the svn
server.
Personally, i would recommend migrating to git altogether, it isn't actually
that difficult. The only issue I had was fixing up the merges.
Sorry I can't be of more help, I'm just letting you know what issues I faced
with svn.

Good luck,
Tim.


Dexter Riley wrote:
> 
> Hello.  My group is currently using subversion on our version control
> server, but would like to move to git as a client.  We are considering
> using git-svn, to avoid revalidating the server software.  My question is,
> are there any major disadvantages to using git-svn versus git?  I know
> that the git repository would be smaller.  I'm more concerned about
> possible svn repository corruption, performance when pushing large merges
> back to svn, and any gotchas you might have encountered.
> Any advice would be greatly appreciated.
> Thanks,
> Ed
> 

-- 
View this message in context: http://www.nabble.com/drawbacks-to-svn-server-%2B-git-svn-vs-git-server--tp25994334p26093326.html
Sent from the git mailing list archive at Nabble.com.
