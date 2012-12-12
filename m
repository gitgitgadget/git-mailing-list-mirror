From: Eugene <ebeletskiy@gmail.com>
Subject: Re: Bad URL passed to RA layer ('https')
Date: Wed, 12 Dec 2012 14:36:23 +0000 (UTC)
Message-ID: <loom.20121212T153500-401@post.gmane.org>
References: <l2y5208b6091005040218t2890b871x1753a1788b67350b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 15:40:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TinTq-0004rT-MU
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 15:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab2LLOj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 09:39:56 -0500
Received: from plane.gmane.org ([80.91.229.3]:52020 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab2LLOj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 09:39:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TinTg-0004fW-8S
	for git@vger.kernel.org; Wed, 12 Dec 2012 15:40:04 +0100
Received: from flock.master.volia.net ([93.72.4.140])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 15:40:04 +0100
Received: from ebeletskiy by flock.master.volia.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 15:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 93.72.4.140 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211354>

Here I. Come <me.detected <at> gmail.com> writes:

> ------------------8<-----------------------
> $ git svn clone https://host/svn/myrepo
> Initialized empty Git repository in /tmp/myrepo/.git/
> Bad URL passed to RA layer: Unrecognized URL scheme for
> 'https://host/svn/myrepo' at /usr/libexec/git-core/git-svn line 1770
> ------------------8<-----------------------


Hi, I have faced with the same problem. Did you find out who to resolve it?
