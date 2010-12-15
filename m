From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: When I merge, a binary file conflict,how can I select between 2 versions?
Date: Wed, 15 Dec 2010 09:01:18 +0000 (UTC)
Message-ID: <loom.20101215T095901-345@post.gmane.org>
References: <loom.20101215T084919-573@post.gmane.org> <20101215083301.GA6946@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 15 10:01:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSnEx-0007tX-QY
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 10:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab0LOJBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 04:01:34 -0500
Received: from lo.gmane.org ([80.91.229.12]:39843 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab0LOJBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 04:01:33 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PSnEq-0007sE-Jn
	for git@vger.kernel.org; Wed, 15 Dec 2010 10:01:32 +0100
Received: from 119.233.251.15 ([119.233.251.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 10:01:32 +0100
Received: from zhangchunlin by 119.233.251.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 10:01:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 119.233.251.15 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163744>

Ilari Liusvaara <ilari.liusvaara <at> elisanet.fi> writes:

> git checkout --theirs -- <file>
> git add <file>
Thanks you very much.That is what I want!
