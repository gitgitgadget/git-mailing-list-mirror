From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: export-ok option
Date: Sat, 16 Sep 2006 21:40:12 +0200
Organization: At home
Message-ID: <eehjtn$ipm$1@sea.gmane.org>
References: <20060916192750.GA27008@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 16 21:40:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOg1G-0000i5-RI
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 21:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWIPTj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWIPTj6
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 15:39:58 -0400
Received: from main.gmane.org ([80.91.229.2]:56247 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751455AbWIPTj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 15:39:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOg0u-0000fV-C7
	for git@vger.kernel.org; Sat, 16 Sep 2006 21:39:44 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 21:39:44 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 21:39:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27128>

Matthias Lederhofer wrote:

> Perhaps there should be another option which allows only those
> repositories to be shown which are in $projects_list.

If $projects_list is a file (and not directory), only repositories
specified there are shown.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
