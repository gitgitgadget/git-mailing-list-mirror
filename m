X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: A documentation to-do list
Date: Wed, 22 Nov 2006 05:29:18 +0000
Message-ID: <200611220529.18568.alan@chandlerfamily.org.uk>
References: <6efbd9b70611211713y4a1574adje48622f7bab6d702@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 05:29:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <6efbd9b70611211713y4a1574adje48622f7bab6d702@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32067>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmkfo-0004hC-V4 for gcvg-git@gmane.org; Wed, 22 Nov
 2006 06:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031050AbWKVF3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 00:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbWKVF3Y
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 00:29:24 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:32928 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1756827AbWKVF3X (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22
 Nov 2006 00:29:23 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gmkfi-0001N6-JE for git@vger.kernel.org; Wed, 22 Nov 2006 05:29:22 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 22 November 2006 01:13, Chris Riddoch wrote:
> Hi, everyone.
>
> Having decided to take it on myself to improve Git's documentation, I
> asked on #git if people had particular things they felt I should focus
> on.  I also was prompted to put up a page on the wiki to make my to-do
> list public.
>
> So, I present:  http://git.or.cz/gitwiki/Documentation_To-Do_List
>
> Add your favorite, specific, lack-of-documentation or badly-described
> annoyance here!

Timely, although I will ask the question here rather than there.

I have started to use git-rebase a lot to try and sort out a project that has 
got lots of long chains of commits on parallel branches doing roughly the 
same thing.  But I do not understand what the --merge flag is about.

git-rebase is clearly doing some form of merge for every commit it moves 
without the  --merge flag, so what does it add?

I thought I understood merging, but clearly I don't.

-- 
Alan Chandler
