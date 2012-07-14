From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe@gmail.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Sat, 14 Jul 2012 09:46:18 +0000 (UTC)
Message-ID: <loom.20120714T114314-421@post.gmane.org>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 11:47:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spywa-00048M-Gm
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 11:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab2GNJqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 05:46:35 -0400
Received: from plane.gmane.org ([80.91.229.3]:49014 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab2GNJqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 05:46:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Spyvn-0002xC-58
	for git@vger.kernel.org; Sat, 14 Jul 2012 11:46:31 +0200
Received: from dslc-082-083-235-018.pools.arcor-ip.net ([82.83.235.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 11:46:30 +0200
Received: from stefan.naewe by dslc-082-083-235-018.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 11:46:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.83.235.18 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201436>

 <mhagger <at> alum.mit.edu> writes:

> 
> From: Michael Haggerty <mhagger <at> alum.mit.edu>
> 
> Add a new Python script, contrib/hooks/post-receive-multimail.py, that
> can be used to send notification emails describing pushes into a git
> repository.  This script is derived from
> contrib/hooks/post-receive-mail, but has many differences, including:

Looks interesting!

Do you have a fork of git.git somewhere that contains the script?
(I find it so much easier these days to simply fetch another repo instead
of applying patches with 'git am'.)

Thanks,
  Stefan
