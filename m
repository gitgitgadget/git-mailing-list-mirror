From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 18:31:52 +0200
Organization: At home
Message-ID: <e06fl8$p9f$1@sea.gmane.org>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Mar 26 18:32:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNY9u-0000zj-Nf
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 18:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWCZQb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 11:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWCZQb4
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 11:31:56 -0500
Received: from main.gmane.org ([80.91.229.2]:32666 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751444AbWCZQbz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 11:31:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FNY9b-0000wD-1F
	for git@vger.kernel.org; Sun, 26 Mar 2006 18:31:47 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Mar 2006 18:31:47 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Mar 2006 18:31:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18043>

I wonder what is the most common case in Linux kernel or git.

1.) renaming the file in the same directory, old-file.c to new-file.c?
2.) moving file to other directory (project reorganization), 
    old-dir/file.c to new-dir/file.c?
3.) splitting file into modules, huge-file.c to file1.c, file2.c?
4.) copying fragment of one file to other?
5.) moving fragment of code from one file to other?

-- 
Jakub Narebski
Warsaw, Poland
