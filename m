X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Topic descriptions
Date: Thu, 7 Dec 2006 11:45:57 +0100
Organization: Dewire
Message-ID: <200612071145.59071.robin.rosenberg.lists@dewire.com>
References: <200612062153.30639.andyparkins@gmail.com> <7v4ps8y7un.fsf@assigned-by-dhcp.cox.net> <200612070837.16412.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 10:44:36 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <200612070837.16412.andyparkins@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33567>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsGjp-0001OI-DC for gcvg-git@gmane.org; Thu, 07 Dec
 2006 11:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032007AbWLGKnh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 05:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760673AbWLGKnh
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 05:43:37 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12342 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1760613AbWLGKng (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 05:43:36 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id C289A803388; Thu,  7 Dec 2006 11:39:42 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 00384-07; Thu,  7 Dec
 2006 11:39:42 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [10.1.2.238]) by
 torino.dewire.com (Postfix) with ESMTP id 690338030A4; Thu,  7 Dec 2006
 11:39:40 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

torsdag 07 december 2006 09:37 skrev Andy Parkins:
> On Wednesday 2006, December 06 22:31, Junio C Hamano wrote:
> > I am unlikely to use such a thing for the "What's in" message,
> > though.  The part that talks about "what the current status is"
> > is much easier to write when I need to talk about "the current";
> > otherwise I'd be forced to remember to think if I need to update
> > the information, every time I touch topic branches.
>
> It wasn't so much the what's current - as you say that would be fairly
> ridiculous as it's so fluid.  It was more a description of the topic.  I've
> got tonnes of branches where I have quickly thought of an idea and started
> work on it, only to get bored and move on.  Describing a topic in such a
> short space as "ap/short-name" is hard.

Your situation sounds similiar to mine, but I don't use regular git branches 
much. Rather I use stacked git instead. Stgit's patches can be though of as 
virtual branches. Instead of creating a dozen branches I have a dozen commits 
managed by stgit that I can choose from (and combine) easily, creating and 
destroying private "branches".

