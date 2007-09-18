From: Andreas Ericsson <ae@op5.se>
Subject: Re: [EGIT PATCH] Add feature and plugin.
Date: Tue, 18 Sep 2007 09:43:57 +0200
Message-ID: <46EF81BD.7010609@op5.se>
References: <20070917185310.GA6042@toast.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ben Konrath <bkonrath@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXXka-0005ke-IX
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 09:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbXIRHoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 03:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754711AbXIRHoA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 03:44:00 -0400
Received: from mail.op5.se ([193.201.96.20]:55835 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbXIRHn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 03:43:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D411B194426;
	Tue, 18 Sep 2007 09:43:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fX35X02QWW9O; Tue, 18 Sep 2007 09:43:58 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 6D8D319447D;
	Tue, 18 Sep 2007 09:43:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070917185310.GA6042@toast.toronto.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58539>

Ben Konrath wrote:
> Hi,
> 
> I made a feature and associated branding plugin for Egit. Including
> these two plugins allows us to build Egit for Fedora but it also makes
> it easy to create an update site for Egit.



> These two plugins also add an
> entry for Egit in Help -> About Eclipse -> Feature Details. 
> 

When you start writing "also" in your commit messages, it's a pretty good
sign that you should have made many smaller commits rathern than one large.

Aside from that, I don't know enough about eclipse, java or xml to be of
any assistance, although I appreciate the efforts put into this.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
