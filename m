From: freefly <free.fly@live.com>
Subject: Re: git version not changed after installing new version
Date: Thu, 26 Jan 2012 17:52:47 +0000 (UTC)
Message-ID: <loom.20120126T185158-378@post.gmane.org>
References: <loom.20120125T173801-500@post.gmane.org>    <loom.20120125T181639-351@post.gmane.org>   <1327517841.31804.75.camel@centaur.lab.cmartin.tk>   <loom.20120125T202642-92@post.gmane.org>  <1327521489.31804.85.camel@centaur.lab.cmartin.tk>  <loom.20120125T211638-609@post.gmane.org> <1327530594.31804.87.camel@centaur.lab.cmartin.tk> <loom.20120126T144828-400@post.gmane.org> <loom.20120126T161101-463@post.gmane.org> <4F2184DC.6070804@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 18:53:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqTVU-00057G-9q
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 18:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966Ab2AZRxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 12:53:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:49130 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab2AZRxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 12:53:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RqTVM-00053q-2q
	for git@vger.kernel.org; Thu, 26 Jan 2012 18:53:00 +0100
Received: from 0x5da1596e.cpe.ge-0-2-0-1104.fsnqu1.customer.tele.dk ([93.161.89.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 18:52:59 +0100
Received: from free.fly by 0x5da1596e.cpe.ge-0-2-0-1104.fsnqu1.customer.tele.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 18:52:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 93.161.89.110 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/534.52.7 (KHTML, like Gecko) Version/5.1.2 Safari/534.52.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189157>

> Put /usr/local/git/bin in front (it is easy to overlook the "git/" in 
> there as software often uses /usr/local/bin)

That worked. Thank you very much.
