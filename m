From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 0/4] gitweb: ViewVC-like "tree_blame" view
Date: Thu, 31 Aug 2006 01:08:07 +0200
Organization: At home
Message-ID: <ed55nu$62k$1@sea.gmane.org>
References: <200608310043.12606.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 31 01:08:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIZAF-0001VC-Pw
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 01:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWH3XIE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 19:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWH3XIE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 19:08:04 -0400
Received: from main.gmane.org ([80.91.229.2]:65514 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751606AbWH3XIC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Aug 2006 19:08:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIZA1-0001S4-Ok
	for git@vger.kernel.org; Thu, 31 Aug 2006 01:07:53 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 01:07:53 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 01:07:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26238>

At the below URL (links of course _won't_ work)
  http://front.fuw.edu.pl/jnareb/tree_blame.html
is output of  "tree_blame" view. One can sort by Date (age), Author, Mode
and Filename. The date view was modelled after 'ls -l' view; the order of
columns probably should be changed to match it more closely.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
