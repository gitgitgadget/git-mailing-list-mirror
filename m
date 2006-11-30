X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 08:31:56 +0000
Message-ID: <200611300831.56858.alan@chandlerfamily.org.uk>
References: <45357CC3.4040507@utoronto.ca> <87bqmpvlxf.wl%cworth@cworth.org> <456E8147.9070304@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 08:32:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <456E8147.9070304@gmx.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32708>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GphKy-0001S7-VZ for gcvg-git@gmane.org; Thu, 30 Nov
 2006 09:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759123AbWK3IcD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 03:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759127AbWK3IcD
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 03:32:03 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:58755 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1759123AbWK3IcB (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30
 Nov 2006 03:32:01 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GphKp-00040R-Rr for git@vger.kernel.org; Thu, 30 Nov 2006 08:31:59 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 30 November 2006 06:59, Raimund Bauer wrote:
> Maybe we could do that _only_ if the index matches HEAD, and otherwise
> keep current behavior?
> So people who don't care about the index won't get tripped up, and when
> you do have a dirty index, you get told about it?
>

I have been(silently)  following the git commit discussion and started being 
fully on the side of git commit -a being the default, but was slowly moving 
over towards the git commit -i being the default camp.

This post seems like a Eureka moment - chew over the problem long enough and 
someone comes in from left field with an off the wall remark that suddenly 
clarifies everything.



-- 
Alan Chandler
