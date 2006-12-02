X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: Re: [RFC] Introduce "git stage" (along with some heresy)
Date: Sat, 02 Dec 2006 14:33:34 -0800
Message-ID: <4571FF3E.4090209@saville.com>
References: <87slfzfri7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 22:33:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <87slfzfri7.wl%cworth@cworth.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33062>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqdQK-0008Su-Dj for gcvg-git@gmane.org; Sat, 02 Dec
 2006 23:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424475AbWLBWd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 17:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424469AbWLBWd3
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 17:33:29 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:22487 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S1424475AbWLBWd3 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006
 17:33:29 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id 7BAE15780F; Sat,  2 Dec 2006 14:29:29 -0800 (PST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth wrote:
> 
> Without staging
> ---------------
> add		Add a file to be managed by git
> 
> rm		Remove a file to no longer be managed by git
> 
> diff		Show the changes in the working tree compared to the
> 		latest commit, (or compared to staged content, if any)
> 
> commit		Commit the current state of all git-managed files
> 
> commit files...	Commit the current state of the specified files
> 

As a newbie like this entire proposal and especially the above.

Wink Saville
