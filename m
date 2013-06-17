From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: GIt error
Date: Mon, 17 Jun 2013 17:52:41 +0400
Message-ID: <20130617175241.4df656642ca4daedbaa4f55d@domain007.com>
References: <E7FBE41B36DC254CB796CE1D6D45B14A0FAE034D@048-CH1MPN1-032.048d.mgd.msft.net>
	<20130617174707.0c44a25130ec28baca9f3e61@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <justin.sathyanathan@accenture.com>, <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Mon Jun 17 15:52:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoZrZ-0006hy-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 15:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269Ab3FQNws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 09:52:48 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:36605 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab3FQNwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 09:52:47 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r5HDqfxY027822;
	Mon, 17 Jun 2013 17:52:42 +0400
In-Reply-To: <20130617174707.0c44a25130ec28baca9f3e61@domain007.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228070>

On Mon, 17 Jun 2013 17:47:07 +0400
Konstantin Khomoutov <kostix+git@007spb.ru> wrote:

> > For Below issue , O/S is Windows7.
> > 1.Iam getting error attached when cloning of repository is done:
> 
> What error?

Okay, the Microsoft Word document with two screenshots has been
scrubbed by the list software but passed through the git-users list
where you posted this as well; answering here.

The errors shown there most probably has the same nature: Git failed to
create a filesystem entry while attempting to check out a revision
after cloning the project.  So the error is not about cloning, it's
about checking out actual files to the work tree.

The rest is explained in my first reply.

[...]
