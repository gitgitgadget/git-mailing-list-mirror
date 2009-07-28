From: Arnaud Bailly <abailly@oqube.com>
Subject: From P4 to Git
Date: Tue, 28 Jul 2009 22:14:34 +0200
Organization: OQube
Message-ID: <85ljm84lat.fsf@oqube.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 22:15:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVt4f-0000qM-L0
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 22:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbZG1UOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 16:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZG1UOx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 16:14:53 -0400
Received: from main.gmane.org ([80.91.229.2]:60779 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbZG1UOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 16:14:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MVt4S-0001kC-7y
	for git@vger.kernel.org; Tue, 28 Jul 2009 20:14:48 +0000
Received: from abailly.pck.nerim.net ([213.41.244.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 20:14:48 +0000
Received: from abailly by abailly.pck.nerim.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 20:14:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abailly.pck.nerim.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Cancel-Lock: sha1:k6KaEd4fPkBcXjyv2vcsQ19zv/w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124271>

Hello,
I am investigating the use of Git in a setting where we:
 1. branches a lot
 2. have a very large codebase

Given Git is developed to handle these 2 issues, I suspect it would be a
very good choice, but I need to gather some experiments feedback and
hard figures on how Git performs (storage use, necessary
bandwidth/resources, maintainance of repositories, cleanup & gc...).

For the experiment part, I am started working on it but would be
interested in other people's experiences.

For the figures part, I think I read somewhere there exists some
statistics on Git usage for Linux kernel. Is this correct ? If true,
where could I find them ? 

Thanks in advance for answering my (maybe pointless) questions and for
producing such a nice piece of software.
-- 
Arnaud Bailly
