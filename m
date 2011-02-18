From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: My git-gui difftool script
Date: Fri, 18 Feb 2011 01:12:17 +0000 (UTC)
Message-ID: <loom.20110218T020325-431@post.gmane.org>
References: <loom.20110217T141642-685@post.gmane.org> <4D5D4CA0.8040301@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 02:12:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEtg-0006mB-C2
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 02:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab1BRBMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 20:12:32 -0500
Received: from lo.gmane.org ([80.91.229.12]:35065 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504Ab1BRBMb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 20:12:31 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PqEtZ-0006hl-OW
	for git@vger.kernel.org; Fri, 18 Feb 2011 02:12:29 +0100
Received: from 119.233.251.15 ([119.233.251.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 02:12:29 +0100
Received: from zhangchunlin by 119.233.251.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 02:12:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 119.233.251.15 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167150>

Michael J Gruber <michaeljgruber+gmane <at> fastmail.fm> writes:

> 
> 
> I don't want to spoil the party, but how is this different from using
> "git difftool -y $FILENAME" for the command?

Because in git-gui I can know which files are modified and which file are staged
more clearly and directly,and I can examine the diff over and over again if I
 like.

> 
> Michael
> 
