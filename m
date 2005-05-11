From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] No more git-jc tree at cox.net
Date: Wed, 11 May 2005 12:12:15 -0700
Message-ID: <7vbr7hshkg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@ucw.cz, <david@dgreaves.com>
X-From: git-owner@vger.kernel.org Wed May 11 21:07:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVwWB-0006S4-Ex
	for gcvg-git@gmane.org; Wed, 11 May 2005 21:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVEKTMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 15:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVEKTMd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 15:12:33 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16024 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262012AbVEKTMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 15:12:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050511191217.EMJG20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 15:12:17 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As some of you may already know, for the past couple of weeks
I've been keeping changes to the core GIT that came from
discussion and review on the mailing list in git-jc tree.  The
intent was to keep the things organized to save time for Linus
when he wants to integrate those good bits.

The purpose Petr stated for git-pb tree is a superset of the
purpose of git-jc tree, and currently git-pb tree is fully
synched up with git-jc.  I do not see much point in duplicated
effort, and also git-jc tree housed at my ISP webspace is
nearing the disc quota.  So I'm removing git-jc tree from there,
at least until I find it a new home.

JIT (my own Porcelain layer) will still be at the same address,
<http://members.cox.net/junkio/jit.git/>.

Thanks.

