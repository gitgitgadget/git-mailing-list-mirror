From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add git_project_index for generating index.aux
Date: Thu, 31 Aug 2006 16:33:05 +0200
Organization: At home
Message-ID: <ed6rv1$3q1$1@sea.gmane.org>
References: <200608311517.11987.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 31 16:36:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIndf-0006m8-4q
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 16:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWHaOfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 10:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHaOfX
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 10:35:23 -0400
Received: from main.gmane.org ([80.91.229.2]:61905 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932326AbWHaOfW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 10:35:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIncc-0006Sd-Mj
	for git@vger.kernel.org; Thu, 31 Aug 2006 16:34:22 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 16:34:22 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 16:34:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26261>

Jakub Narebski wrote:

> This action is not linked from anywhere, one must put p=project_index
> into query string by hand.

Of course it should be a=project_index (or rather ?a=project_index).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
