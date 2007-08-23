From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: commit author x commit committer issue
Date: Wed, 22 Aug 2007 22:05:55 -0700
Message-ID: <20070823050555.GB4978@muzzle>
References: <46B9C92B.3000000@st.com> <20070816092002.GD16849@muzzle> <8b65902a0708220307g2cb4b290s9bbf4603af7489fa@mail.gmail.com> <8b65902a0708220317t2b3dd01csef460a943ed2ef37@mail.gmail.com> <7vir77i77o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	Richard MUSIL <richard.musil@st.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 07:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO4u3-0004AN-FA
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 07:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757644AbXHWFGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 01:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757727AbXHWFGQ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 01:06:16 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37526 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757631AbXHWFF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 01:05:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6902F2DC08D;
	Wed, 22 Aug 2007 22:05:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vir77i77o.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56452>

Junio C Hamano <gitster@pobox.com> wrote:
> "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com> writes:
> 
> > Oops, sory, I'm completly wrong: the git-svn-id is put on the commit
> > log in the Git repo, not on the SVN repo.
> > Please, ignore me.
> 
> I do not think it is wrong to tack that to the commit message
> you push it back to SVN... am I missing something?

It's actually possible to add a revprop in SVN that is not immediately
visible to SVN users.

-- 
Eric Wong
