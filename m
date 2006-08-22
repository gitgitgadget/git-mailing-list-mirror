From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] gitweb: Yet another cleanup series
Date: Tue, 22 Aug 2006 17:03:37 +0200
Organization: At home
Message-ID: <ecf6c7$40e$1@sea.gmane.org>
References: <200608221651.19629.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 22 17:04:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFXne-0007hG-Nf
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 17:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWHVPEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 11:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWHVPEP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 11:04:15 -0400
Received: from main.gmane.org ([80.91.229.2]:37312 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932297AbWHVPEO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 11:04:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFXnE-0007ax-Vf
	for git@vger.kernel.org; Tue, 22 Aug 2006 17:03:53 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 17:03:52 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 17:03:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25859>

Jakub Narebski wrote:

> This series of patches commences further gitweb cleanup.
> It is based on earlier series of patches:
> * gitweb: Added parse_difftree_raw_line function for later use
> * gitweb: Use parse_difftree_raw_line in git_difftree_body

Actually, I think that only first patch in this series needs
"parse_difftree_raw_line" series.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
