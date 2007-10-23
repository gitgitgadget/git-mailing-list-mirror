From: "Scott R Parish" <srp@srparish.net>
Subject: Re: [PATCH trailing ws fixed] use only the PATH for exec'ing 
     gitcommands
Date: Tue, 23 Oct 2007 16:27:42 -0500 (CDT)
Message-ID: <1193174862.v1.fusewebmail-240137@f>
References: <20071022170148.GB29642@srparish.net> 
     <20071022190102.GA23714@steel.home> 
     <20071023040844.GQ16291@srparish.net> 
     <20071023211202.GA729@steel.home>
Reply-To: srp@srparish.net
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 23:28:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkRI5-0000dP-Aa
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 23:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXJWV1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbXJWV1q
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 17:27:46 -0400
Received: from smtp-gw7.mailanyone.net ([208.70.128.55]:59166 "EHLO
	smtp-gw7.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbXJWV1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 17:27:45 -0400
Received: from mailanyone.net
	by smtp-gw7.mailanyone.net with esmtpa (MailAnyone extSMTP srp)
	id 1IkRHs-0007le-By; Tue, 23 Oct 2007 16:27:44 -0500
Received: from 127.0.0.1
        (FuseMail web AccountID 240137)
        by www.fusemail.com with HTTP;
        Tue, 23 Oct 2007 16:27:42 -0500 (CDT)
In-Reply-To: <20071023211202.GA729@steel.home>
User-Agent: FuseWebmail
X-Priority: 3
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62160>

> Acked-by: Alex Riesen <raa.lkml@gmail.com>
>
> Don't forget to mention it needs the patch from Johannes re "deducing
> exec_path from calls to git with a relative path" and your
> "current_exec_path"-patch. Took me a while to figure these out...

Sorry about that! I was basing my patches off the head of spearce, as it
sounded like Junio was going to pick that stuff up.

sRp
