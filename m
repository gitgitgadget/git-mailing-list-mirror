X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] qgit-1.5.3
Date: Mon, 13 Nov 2006 12:30:17 +0100
Message-ID: <45585749.5030200@op5.se>
References: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 13 Nov 2006 11:30:32 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31294>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gja1C-0001EQ-PE for gcvg-git@gmane.org; Mon, 13 Nov
 2006 12:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754498AbWKMLaX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 06:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754500AbWKMLaX
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 06:30:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:23707 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1754498AbWKMLaW (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 06:30:22 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id EEF136BE27; Mon,
 13 Nov 2006 12:30:20 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 18F5B6BE24; Mon, 13 Nov 2006 12:30:18 +0100 (CET)
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba wrote:
> 
> Download tarball from http://www.sourceforge.net/projects/qgit
> or directly from git public repository
> git://git.kernel.org/pub/scm/qgit/qgit.git
> 

Love the tool, but can't fetch the tag. Did you forget to

	$ git push origin 1.5.3

?

git describe tells me that I have qgit-1.5.2-gb764f9b

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
