From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH] gitweb: Add =?utf-8?b?cGF0aF9pbmZv?= tests =?utf-8?b?dG8JdC90OTUwMC1naXR3ZWItc3RhbmRhbG9uZS1uby1lcnJvcnMuc2g=?=
Date: Thu, 2 Oct 2008 16:41:30 +0000 (UTC)
Message-ID: <loom.20081002T164037-13@post.gmane.org>
References: <20081002145010.19247.44420.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 18:43:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlRGN-0005Gx-Ry
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 18:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbYJBQll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 12:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbYJBQll
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 12:41:41 -0400
Received: from main.gmane.org ([80.91.229.2]:51459 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753910AbYJBQlk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 12:41:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KlRFC-0000zc-Vv
	for git@vger.kernel.org; Thu, 02 Oct 2008 16:41:39 +0000
Received: from adsl-75-24-208-45.dsl.pltn13.sbcglobal.net ([75.24.208.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 16:41:38 +0000
Received: from raible by adsl-75-24-208-45.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 16:41:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.208.45 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.30 Safari/525.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97360>

Jakub Narebski <jnareb <at> gmail.com> writes:

> 
> Note that those tests only that there are no errors nor warnings
> from Perl; they do not check for example if gitweb doesn't use
> ARRAY(0x8e3cc20) instead of correct value in links, etc.
> 
> Signed-off-by: Jakub Narebski <jnareb <at> gmail.com>
> ---

s/only that/only check that/
