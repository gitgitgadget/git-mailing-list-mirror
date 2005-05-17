From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [RFH] Janitor projects around core GIT
Date: Tue, 17 May 2005 11:49:10 -0400
Message-ID: <8764xh26q1.fsf@coraid.com>
References: <7vpsvqihkh.fsf@assigned-by-dhcp.cox.net>
	<4289799A.3040204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 17 17:58:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY4PV-0002PV-32
	for gcvg-git@gmane.org; Tue, 17 May 2005 17:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEQPzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 11:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVEQPyN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 11:54:13 -0400
Received: from main.gmane.org ([80.91.229.2]:9432 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261800AbVEQPxb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 11:53:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DY4M5-0001tI-Cq
	for git@vger.kernel.org; Tue, 17 May 2005 17:51:37 +0200
Received: from adsl-19-26-213.asm.bellsouth.net ([68.19.26.213])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2005 17:51:37 +0200
Received: from ecashin by adsl-19-26-213.asm.bellsouth.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2005 17:51:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-19-26-213.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:9eFbpKJkaBEYi9ugIa4XKJEQAB4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Junio C Hamano wrote:
>>  * Rewrite command line parsing code, probably using GNU getopt.
>>    I have three gripes about option parsing in the current code:
>
>
> Use argp.  It supports short and long options, and is highly
> flexible. "info argp" should work on most Linux boxes.

Or "info libc argp" (on my debian sarge system).

-- 
  Ed L Cashin <ecashin@coraid.com>

