From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: Dividing up a large merge.
Date: Wed, 15 Jul 2009 10:47:39 -0400
Message-ID: <20090715144739.GA14846@cthulhu>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com> <20090715002926.GA26630@huya.quicinc.com> <20090715122828.GA6570@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davidb@quicinc.com, Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 15 16:47:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR5lr-00066Q-BF
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 16:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbZGOOrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 10:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754885AbZGOOrk
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 10:47:40 -0400
Received: from cthulhu.elder-gods.org ([140.239.99.253]:55708 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbZGOOrj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 10:47:39 -0400
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id AC09E822107; Wed, 15 Jul 2009 10:47:39 -0400 (EDT)
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, davidb@quicinc.com,
	Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090715122828.GA6570@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123316>

* Theodore Tso (tytso@mit.edu) [090715 08:28]:
> And, if you believe your release cycle is going to run for more than,
> say, 2-3 months, I suggest that you keep things in a single linear
> patch stream.  You can keep the patch series under git control, and
> then rebase periodically; I'd suggest rebasing once a mainline release
> happens (i.e., when 2.6.X is released), and then again after most of
> the major changes have been merged in and the tree has settled down
> (i.e., after 2.6.X-rc2 or 2.6.X-rc3).

or use TopGit

http://repo.or.cz/w/topgit.git

        --larry
