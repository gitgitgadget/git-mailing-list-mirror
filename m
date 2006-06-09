From: Jakub Narebski <jnareb@gmail.com>
Subject: RE: Git-daemon messing up permissions for gitweb
Date: Fri, 09 Jun 2006 21:27:03 +0200
Organization: At home
Message-ID: <e6ci1u$939$1@sea.gmane.org>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957855@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 09 21:27:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fomdg-0008Ve-JA
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 21:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWFIT1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 15:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbWFIT1L
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 15:27:11 -0400
Received: from main.gmane.org ([80.91.229.2]:65173 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030437AbWFIT1J (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 15:27:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FomdP-0008T0-Hs
	for git@vger.kernel.org; Fri, 09 Jun 2006 21:27:07 +0200
Received: from 212-87-13-71.sds.uw.edu.pl ([212.87.13.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 21:27:07 +0200
Received: from jnareb by 212-87-13-71.sds.uw.edu.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 21:27:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212-87-13-71.sds.uw.edu.pl
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21543>

Post, Mark K wrote:

> [core]
>         repositoryformatversion = 0
>         filemode = true
>         sharedrepository = true
> 
> I see that the case of the value is different from what you typed:
>         SharedRepository = true
> Is that significant (as almost everything is)?

No, the keys are case-insensitive.

-- 
Jakub Narebski
Warsaw, Poland
