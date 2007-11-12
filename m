From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is it possible for git to remember the options preference for "git log"?
Date: Mon, 12 Nov 2007 01:56:03 +0100
Organization: At home
Message-ID: <fh88av$2om$1@ger.gmane.org>
References: <f17812d70711111633u6c00d182u532fef1c16c3c94a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 01:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrNbm-0004Gn-G6
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 01:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbXKLA4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 19:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbXKLA4n
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 19:56:43 -0500
Received: from main.gmane.org ([80.91.229.2]:39300 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbXKLA4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 19:56:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrNbT-0001Kr-Hn
	for git@vger.kernel.org; Mon, 12 Nov 2007 00:56:39 +0000
Received: from abwz76.neoplus.adsl.tpnet.pl ([83.8.249.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 00:56:39 +0000
Received: from jnareb by abwz76.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 00:56:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwz76.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64544>

eric miao wrote:


> Most of the time I'm using git-log for inspecting a brief history
> and insert/remove/modify commits between, which I have to
> type "git log --abbrev-commit --pretty=oneline" every time. Is
> it possible for git to remember this command line options
> preference?
> 
> And no, I don't really want to use shell's alias or something
> else, I was just used to type "git xxx" :-)

You can always use (global) _git_ alias ;-p

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
