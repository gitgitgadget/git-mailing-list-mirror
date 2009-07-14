From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+dfhy@trn.iki.fi>
Subject: Re: Proper tracking of copies in git log and others
Date: Tue, 14 Jul 2009 15:19:45 +0300
Message-ID: <4A5C77E1.7020500@trn.iki.fi>
References: <4A4F8258.5070701@trn.iki.fi> <BLU0-SMTP94B7E43F5EE983A2F9BFA8AE2D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Jul 14 14:20:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQgzK-0004tT-SN
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 14:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbZGNMTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 08:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbZGNMTy
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 08:19:54 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:48641 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbZGNMTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 08:19:53 -0400
Received: from trn.iki.fi (84.250.38.215) by kirsi1.inet.fi (8.5.014)
        id 49F6055A02BA82F0; Tue, 14 Jul 2009 15:19:50 +0300
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id EF9F345B71005;
	Tue, 14 Jul 2009 15:19:41 +0300 (EEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP;
	Tue, 14 Jul 2009 15:19:41 +0300 (EEST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090616)
In-Reply-To: <BLU0-SMTP94B7E43F5EE983A2F9BFA8AE2D0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123239>

> You could apply that patch and test it out.  Perhaps you could address
> Junio's concern or reignite some interest from the original author.

The patch works fine here and solves my issue. Hopefully it can be made 
part of the distribution.

Tracking other (intermediate) copies would be a plus but I have 
absolutely no time to work on git as I am trying to use VCS to reduce my 
workload, not to increase it :)
