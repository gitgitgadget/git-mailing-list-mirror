From: bain <bain@devslashzero.com>
Subject: Re: teamGit v0.0.3
Date: Sun, 5 Oct 2008 08:13:50 -0700 (PDT)
Message-ID: <22717858-31ce-4979-9d8e-167601f0e82e@i24g2000prf.googlegroups.com>
References: <8ce0dfd6-2bd7-4e94-901f-b7c9bbd114aa@w39g2000prb.googlegroups.com> 
	<m38wt3qrij.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 17:15:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmVK2-0008Qc-VH
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 17:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYJEPNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 11:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbYJEPNx
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 11:13:53 -0400
Received: from yx-out-2122.google.com ([74.125.44.26]:12203 "EHLO
	yx-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbYJEPNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 11:13:52 -0400
Received: by yx-out-2122.google.com with SMTP id 35so1174821yxh.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 08:13:50 -0700 (PDT)
Received: by 10.151.155.10 with SMTP id h10mr115480ybo.15.1223219630940; Sun, 
	05 Oct 2008 08:13:50 -0700 (PDT)
In-Reply-To: <m38wt3qrij.fsf@localhost.localdomain>
X-IP: 59.95.10.32
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) 
	Gecko/2008072820 Firefox/3.0.1,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97509>

> Could you please add info about teamGit to the git wiki pagehttp://git.or.cz/gitwiki/InterfacesFrontendsAndTools? I think
> just below now defunct and unmaintained KGit (or just above) would
> be best.
Will do ASAP

> P.S. How it differs from othe Git GUIs, like gitk+git-gui, qgit
> or git-cola?It differs from
1. gitk and git-gui : its not as ugly :p, well actually neither of
them fulfilled speed requirements on my 'not so old' but 'ancient by
computer standards' p4 laptop.
2. qgit4 : actually its not very different except that i don't find
interface of qgit too friendly. Neway i would have used qgit instead
if it was at the stage its now two years back. i also tried to base my
code off qgit's plumbing unfortunately it wasn't easy to rip it. I
didn't like the complicated unreadable typical c++ code design so
chose not to participate in there. (to make things clear qgit is
excellent, and wonderfully coded. Marc has done real good job of using
c++ to its fullest and this is not a comment on his coding
capabilities. Its only that i am just too poor a c++ developer and
consider c++ too confusing for active contirbution in core design by
others.) So one of the aims i have in teamGit is to keep it as clean
and simple as possible (not easy goal i must add and i might already
be off).
3. git-cola: i hate scirpting used as mainstay applications.

Besides all of the above teamGit differes drastically in its end
roadmap.
It will ultimately be complete project management tool. A developer
should be able to completely manage his coding activities from inside
teamGit, plus a team collaberation added as an advantage.

But these are reallllyyyyyy lloooonnngg term goals, if it ever gets
there.

Thanks,
BAIN
