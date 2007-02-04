From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'git config' vs 'git repo-config'
Date: Sun, 04 Feb 2007 11:36:57 +0100
Organization: At home
Message-ID: <eq4ctk$9ae$3@sea.gmane.org>
References: <e5bfff550702040138r6580c36agf86e8f8191a40021@mail.gmail.com> <7v8xfetft6.fsf@assigned-by-dhcp.cox.net> <e5bfff550702040200y4f09070fia3716ca949fddac7@mail.gmail.com> <7v4pq2tet5.fsf@assigned-by-dhcp.cox.net> <e5bfff550702040223h56f1524x9e6c460445874063@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 11:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDen4-0001nn-Kw
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 11:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbXBDKkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 05:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbXBDKkI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 05:40:08 -0500
Received: from main.gmane.org ([80.91.229.2]:43966 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbXBDKkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 05:40:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HDemx-00015v-0f
	for git@vger.kernel.org; Sun, 04 Feb 2007 11:40:03 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 11:40:03 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 11:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38682>

Marco Costalba wrote:

> I plan to release a point release after git-1.5 is out, so I'm
> wondering if renaming git-repo-config --> git-config also in qgit.

This would mean that you cannot use new qgit with older git instalations.
Not a good idea, I think...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
