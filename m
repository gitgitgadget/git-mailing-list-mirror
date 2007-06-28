From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: most commonly used git commands?
Date: Thu, 28 Jun 2007 15:54:45 +0200
Organization: eudaptics software gmbh
Message-ID: <4683BDA5.996874EF@eudaptics.com>
References: <20070625064017.GA2839@mellanox.co.il>  <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
	  <20070625071752.GB15343@mellanox.co.il>  <Pine.LNX.4.64.0706250846200.4059@racer.site>
	 <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com> <Pine.LNX.4.64.0706281408280.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 16:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3v8e-00071g-9G
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 16:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756318AbXF1Oi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 10:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279AbXF1Oi0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 10:38:26 -0400
Received: from main.gmane.org ([80.91.229.2]:33303 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072AbXF1OiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 10:38:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I3unV-0007qc-PR
	for git@vger.kernel.org; Thu, 28 Jun 2007 16:16:38 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 16:16:37 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 16:16:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51111>

Johannes Schindelin wrote:
> On Thu, 28 Jun 2007, Alex Riesen wrote:
> > On 6/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > git update-index is really not user-friendly. That is why we have "git
> > > add". It is commonly used as a porcelain _instead of_ update-index.
> >
> > which reminds me: "git-add" lacks "--chmod=[+-]x".
> 
> ???
> 
> Do you mean "chmod a+x blub && git add blub"?

No. It was meant as Alex said it. Windows (MinGW) doesn't understand
"chmod a+x blub".

-- Hannes
