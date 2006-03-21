From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Bad merging with stgit or git
Date: Tue, 21 Mar 2006 14:39:24 -0500
Message-ID: <20060321193924.GD14579@fieldses.org>
References: <1142969653.4749.109.camel@praia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Mar 21 20:39:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLmhf-0005E8-PS
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 20:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWCUTj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 14:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWCUTj1
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 14:39:27 -0500
Received: from mail.fieldses.org ([66.93.2.214]:11431 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S965076AbWCUTj0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 14:39:26 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1FLmhQ-0006My-CG; Tue, 21 Mar 2006 14:39:24 -0500
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Content-Disposition: inline
In-Reply-To: <1142969653.4749.109.camel@praia>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17783>

On Tue, Mar 21, 2006 at 04:34:13PM -0300, Mauro Carvalho Chehab wrote:
> It shouldn't have any conflicts here for Linus, since those patches came
> from his tree.

What do you mean by "those patches came from his tree"?  If you're
actually cherry-picking patches from his tree and applying them to
yours, then you're not reproducing the same commits he has--you're just
creating new commits that happen to have nearly identical content.

--b.
