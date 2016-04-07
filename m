From: daurnimator <quae@daurnimator.com>
Subject: Re: [PATCH] git-stash: Don't GPG sign when stashing changes
Date: Thu, 7 Apr 2016 02:24:45 +0000 (UTC)
Message-ID: <loom.20160407T042319-468@post.gmane.org>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 04:30:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anzi2-0002AX-7V
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 04:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbcDGCaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 22:30:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:41678 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbcDGCaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 22:30:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1anzhs-00027L-A6
	for git@vger.kernel.org; Thu, 07 Apr 2016 04:30:04 +0200
Received: from 203-206-184-80.perm.iinet.net.au ([203.206.184.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 04:30:04 +0200
Received: from quae by 203-206-184-80.perm.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 04:30:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.206.184.80 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.108 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290901>

Cameron Currie <me <at> cameroncurrie.net> writes:
> This is helpful for folks with commit.gpgsign = true in their .gitconfig.

> https://github.com/git/git/pull/186

I too would like this.
Bumping due to lack of attention.
