From: Eric Hanchrow <offby1@blarg.net>
Subject: Re: visualizing Git's Git repo
Date: Mon, 26 May 2008 15:59:40 -0700
Message-ID: <87ve104qoz.fsf@offby1.atm01.sea.blarg.net>
References: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 01:09:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0loM-0006oM-N5
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbYEZXIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755376AbYEZXIM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:08:12 -0400
Received: from main.gmane.org ([80.91.229.2]:48187 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbYEZXIL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:08:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K0lnW-0007kE-Sk
	for git@vger.kernel.org; Mon, 26 May 2008 23:08:10 +0000
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 May 2008 23:08:10 +0000
Received: from offby1 by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 May 2008 23:08:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: q-static-138-125.avvanta.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:A5kewyz8/Z+Wq1xLRddG5hy36j0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82970>

You might not know -- I didn't until five minutes ago -- that you can
omit entire branches, like this:

        $ gitk --all  ^refs/remotes/origin/man ^refs/remotes/origin/html

-- 
The story will be familiar to anyone who has ever seen a movie about a
troubled athlete and a brilliant coach.  It will also be familiar to
anyone who has not.  -- Roger Ebert, on "Stick It" (2006)
