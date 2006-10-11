From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry
 in tree listing
Date: Wed, 11 Oct 2006 17:35:22 +0200
Message-ID: <452D0F3A.1080800@op5.se>
References: <20061010191904.99261.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 17:38:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXg7O-0008As-JY
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 17:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWJKPf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 11:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWJKPf1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 11:35:27 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:32384 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161047AbWJKPf1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 11:35:27 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 48FAF6BCBC; Wed, 11 Oct 2006 17:35:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [10.1.10.102] (unknown [62.209.168.4])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D69DE6BCEA; Wed, 11 Oct 2006 17:35:22 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: ltuikov@yahoo.com
In-Reply-To: <20061010191904.99261.qmail@web31809.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28721>

Luben Tuikov wrote:
> 
> The question is: Given the average engineer, what is the gitweb interface
> such that they can start using it fastest with the minimum amount of
> questions?
> 

Originally, the question was about average gitweb users. I'm sorry 
Luben, but as long as you propagate links that are not
a) blue
b) underlined
I'll have to disagree with everything you say out of pure principle.

> 
> The golden question:
> What is the interface such that both git-experts and never-seen-git-
> but-know-about-SCMs engineers can find it intuitive to use with minimal
> amount of questions?
> 

Just make links blue and underlined and people will click them out of 
curiousity. 100% guaranteed. Try to spoonfeed engineers and they will 
spit on you, because engineers like to figure things out, even if 
they're obvious. Try to make things intuitive for average users and you 
will be wrong, because intuition is highly culture- and experience 
oriented. Try to make it foolproof and you will fail, because fools are 
so ingenious.

The one and only thing everyone looking at a gitweb interface has in 
common is curiousity, so appeal to that rather than trying any of the 
doomed paths above.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
