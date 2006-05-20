From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] fmt-patch: Support --attach
Date: Sat, 20 May 2006 16:16:22 +0200
Organization: At home
Message-ID: <e4n8b3$ari$1@sea.gmane.org>
References: <Pine.LNX.4.63.0605201537290.17869@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat May 20 16:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhSG0-0007mO-Mg
	for gcvg-git@gmane.org; Sat, 20 May 2006 16:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWETOQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 10:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWETOQi
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 10:16:38 -0400
Received: from main.gmane.org ([80.91.229.2]:60641 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964856AbWETOQh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 10:16:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FhSFm-0007jd-8L
	for git@vger.kernel.org; Sat, 20 May 2006 16:16:26 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 May 2006 16:16:26 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 May 2006 16:16:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20380>

Johannes Schindelin wrote:

> -             printf("From %s  Thu Apr 7 15:13:13 2005\n",
> -                    sha1_to_hex(commit->object.sha1));
> +             printf("From %s Mon Sep 17 00:00:00 2001\n", sha1);

What's with the date?

-- 
Jakub Narebski
Warsaw, Poland
