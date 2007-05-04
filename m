From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 04 May 2007 11:19:42 +0200
Organization: eudaptics software gmbh
Message-ID: <463AFAAE.853DEF7B@eudaptics.com>
References: <463ADE51.2030108@gmail.com>
		 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
		 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net> <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 11:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjtxE-00041R-Dn
	for gcvg-git@gmane.org; Fri, 04 May 2007 11:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbXEDJTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 05:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbXEDJTx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 05:19:53 -0400
Received: from main.gmane.org ([80.91.229.2]:49402 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933045AbXEDJTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 05:19:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hjtx3-00056v-OR
	for git@vger.kernel.org; Fri, 04 May 2007 11:19:45 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 11:19:45 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 11:19:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46150>

Alex Riesen wrote:
> On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> > My preference is (2), (3) and then (1), but I do not have
> > offhand a suggestion for a good metacharacter we could use.
> 
> "./" :)

+1, without the :)
and ../ should DWIM, too.

-- Hannes
