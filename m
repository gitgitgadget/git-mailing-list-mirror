From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] git-tag man: when to use lightweight or annotated tags
Date: Fri, 26 Jul 2013 17:13:23 -0400
Message-ID: <51F2E673.5020401@xiplink.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Daniele Segato <daniele.segato@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 23:13:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2pKB-0005hK-Rr
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 23:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025Ab3GZVNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 17:13:15 -0400
Received: from smtp82.ord1c.emailsrvr.com ([108.166.43.82]:50666 "EHLO
	smtp82.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933010Ab3GZVNN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jul 2013 17:13:13 -0400
X-Greylist: delayed 22890 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2013 17:13:13 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp3.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 63221501FE;
	Fri, 26 Jul 2013 17:13:12 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp3.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0B0EF5036E;
	Fri, 26 Jul 2013 17:13:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <51F2AFBA.4020602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231202>

On 13-07-26 01:19 PM, Daniele Segato wrote:
> 
> By the way which is your role in the community?
> Don't want to be rude, I just don't know who I'm talking about :) the
> documentation maintainer?

I'm just a git user and (very) occasional contributor.

There's not much structure to the git community.  Anyone who wants git to
change can post a patch (or patch series) to this list.  The patch can touch
any area of the code, and it's considered good manners to CC whoever last
touched the part(s) of the code being patched.

The patch is discussed and revised as needed, and eventually the patch
thread's participants arrive at a consensus as to whether or not the patch
should become a part of git.  If the patch is accepted the git maintainer
(Junio C. Hamano) shepherds the patch through git's release process.  See
this note:
	http://git-blame.blogspot.ca/p/a-note-from-maintainer.html
for more about that and other aspects of the git development community.

		M.
