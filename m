From: Miles Bader <miles@gnu.org>
Subject: Re: setting up tracking on push
Date: Sat, 07 Mar 2009 01:29:43 +0900
Message-ID: <87d4cuobrc.fsf@catnip.gol.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	<76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
	<alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
	<buoy6vi297q.fsf@dhlpc061.dev.necel.com>
	<49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	<76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 17:31:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfcxa-0006sb-8g
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbZCFQ35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZCFQ35
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:29:57 -0500
Received: from main.gmane.org ([80.91.229.2]:33184 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbZCFQ34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:29:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lfcvp-0005bu-0G
	for git@vger.kernel.org; Fri, 06 Mar 2009 16:29:53 +0000
Received: from 218.231.175.8.eo.eaccess.ne.jp ([218.231.175.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 16:29:52 +0000
Received: from miles by 218.231.175.8.eo.eaccess.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 16:29:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 218.231.175.8.eo.eaccess.ne.jp
System-Type: x86_64-unknown-linux-gnu
Cancel-Lock: sha1:PeqyNp60nQU57Hy0sskxguf8zPA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112463>

Jay Soffian <jaysoffian@gmail.com> writes:
> I don't think we need a new command, but it would probably fit into
> git remote
>
> $ git remote track <remote> [<branch>]

That seems a bit backwards -- it's more of a branch operation than a
remote operation...

-Miles

-- 
Mayonnaise, n. One of the sauces that serve the French in place of a state
religion.
