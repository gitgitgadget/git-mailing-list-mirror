From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: EGIT, was Re: [PATCH] Fix nullpointer exceptions in Quickdiff
Date: Sat, 12 Jul 2008 00:15:58 +0200
Message-ID: <200807120015.58909.robin.rosenberg.lists@dewire.com>
References: <1215729672-26906-1-git-send-email-robin.rosenberg@dewire.com> <200807112334.47552.robin.rosenberg@dewire.com> <alpine.DEB.1.00.0807112249010.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:22:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHR0H-0000f5-11
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbYGKWVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbYGKWVO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:21:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18716 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755917AbYGKWVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:21:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 482EC802C0D;
	Sat, 12 Jul 2008 00:21:12 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ewxb-Ipn8xj0; Sat, 12 Jul 2008 00:21:11 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D328B802846;
	Sat, 12 Jul 2008 00:21:11 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807112249010.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88193>

fredagen den 11 juli 2008 23.50.07 skrev Johannes Schindelin:
> Hi Andreas,
> 
> On Fri, 11 Jul 2008, Robin Rosenberg wrote:
> 
> > 
> > --- 
> > I saw some problem when resources were no longer in the worspace, such as during a bisectg. 
> > This one should probably just be squashed into patch 1.
> 
> This patch is for egit, before you ask.
> 
> But be prepared for a lot of unmarked Windows discussion, somebody wants 
> to shift msysGit's mail list payload to git@vger ;-)

Aaaaaaaaaaa.... I've take a leave now .)

-- robin	
