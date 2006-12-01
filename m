X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Fri, 1 Dec 2006 23:33:16 +0000
Message-ID: <200612012333.16588.alan@chandlerfamily.org.uk>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301253380.3513@woody.osdl.org> <200612010834.22916.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 23:34:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <200612010834.22916.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32987>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqHto-0005Yd-8C for gcvg-git@gmane.org; Sat, 02 Dec
 2006 00:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162273AbWLAXdu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 18:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162260AbWLAXde
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 18:33:34 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:39124 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1162273AbWLAXdT (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1
 Dec 2006 18:33:19 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GqHsb-0001pt-TH for git@vger.kernel.org; Fri, 01 Dec 2006 23:33:17 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 01 December 2006 08:34, Andy Parkins wrote:
> How about this:
...
>
> Hence,
>
> git-add becomes git-prepare and does

Why can't it stay as git-add

It means "add the current state of the content to the index"

It has the useful property that git-commit -a can be seen as a short cut for 
add all the files in the working try and commit. 


-- 
Alan Chandler
