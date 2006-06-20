From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make CSS file gitweb/gitweb.css more readable
Date: Tue, 20 Jun 2006 05:25:34 +0200
Organization: At home
Message-ID: <e77prc$v40$1@sea.gmane.org>
References: <e76qbi$tt9$1@sea.gmane.org> <7vwtbc9a45.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 20 05:25:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsWs7-0004oD-En
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 05:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965428AbWFTDZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 23:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965442AbWFTDZo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 23:25:44 -0400
Received: from main.gmane.org ([80.91.229.2]:39575 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965428AbWFTDZo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 23:25:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FsWry-0004n5-PE
	for git@vger.kernel.org; Tue, 20 Jun 2006 05:25:38 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 05:25:38 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 05:25:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22162>

Junio C Hamano wrote:

> Jakub, I've been applying your patches after hand-fixing but it
> appears that there is serious whitespace breakage on the mail
> path somewhere between you and the mailing list.  Please check
> your MUA.

Checking:
--inserted file--
test
        tab test
         tab+space test
 space test
empty line below

line with tab only below
        
-- 
Signature
--end of inserted file--

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
