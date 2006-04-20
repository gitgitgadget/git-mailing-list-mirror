From: Jakub Narebski <jnareb@gmail.com>
Subject: Branch metainformation
Date: Thu, 20 Apr 2006 09:39:09 +0200
Organization: At home
Message-ID: <e27dqv$u6f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Apr 20 09:39:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWTlJ-0000vZ-QM
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 09:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWDTHjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 03:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWDTHjf
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 03:39:35 -0400
Received: from main.gmane.org ([80.91.229.2]:34501 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750753AbWDTHje (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 03:39:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FWTl7-0000tH-Pu
	for git@vger.kernel.org; Thu, 20 Apr 2006 09:39:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Apr 2006 09:39:25 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Apr 2006 09:39:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18959>

It seems that ever so often there is question posted on this list on which
the answer is to add '+' in 'pu' branch 'Pull:' line. I think that it is
not a good policy to have puller to remember which branches can be
fast-forwarded, and which needs to be merged. It should be an information
set and stored by person managing the branch (pullee), as some kind of
metainformation for the branch (like description and optional signature is
for tags).

Perhaps then there would be a place for short, one-line description of the
branch...

-- 
Jakub Narebski
Warsaw, Poland
