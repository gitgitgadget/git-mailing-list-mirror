X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Resolving conflicts
Date: Fri, 1 Dec 2006 08:10:25 +0000
Message-ID: <200612010810.25232.alan@chandlerfamily.org.uk>
References: <456FD461.4080002@saville.com> <200612010730.25700.alan@chandlerfamily.org.uk> <456FDCB5.9040907@saville.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 08:10:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <456FDCB5.9040907@saville.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32866>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq3Ts-0003NE-9V for gcvg-git@gmane.org; Fri, 01 Dec
 2006 09:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967420AbWLAIKa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 03:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967496AbWLAIKa
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 03:10:30 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:54743 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S967492AbWLAIKa (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1
 Dec 2006 03:10:30 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gq3TY-0007xD-TA; Fri, 01 Dec 2006 08:10:28 +0000
To: Wink Saville <wink@saville.com>
Sender: git-owner@vger.kernel.org

On Friday 01 December 2006 07:41, Wink Saville wrote:
> Alan Chandler wrote:
> > On Friday 01 December 2006 07:06, Wink Saville wrote:
> >
> > Take a look in these two files - you should see conflict markers of the
> > form <<<<<<<<<<<<<<<<
> > some content
> > ================
> > some other content
>
> That's what I thought but there isn't any "<<<<<" and git-diff also seems
> to indicate no differences:

This is at the limit of my understanding, but perhaps file permission problems 
could have been the cause (was also thinking white space - but to my 
recollection is that that DOES cause resolution markers) 

I think you'll have to wait for experts from the list to comment.
-- 
Alan Chandler
