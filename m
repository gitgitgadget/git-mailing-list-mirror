X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: StGit-enabled bash-prompt
Date: Fri, 27 Oct 2006 20:54:04 +0200
Organization: Dewire
Message-ID: <200610272054.04948.robin.rosenberg.lists@dewire.com>
References: <200610262317.30209.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0610270957020.9123@dildano.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 19:18:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0610270957020.9123@dildano.hawaga.org.uk>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30341>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdWvJ-0005Ou-OA for gcvg-git@gmane.org; Fri, 27 Oct
 2006 20:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750905AbWJ0S7T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 14:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbWJ0S7T
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 14:59:19 -0400
Received: from [83.140.172.130] ([83.140.172.130]:64861 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1750862AbWJ0S7S (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 14:59:18 -0400
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id BD7BA8028A2; Fri, 27 Oct 2006 20:56:02 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 28115-10; Fri, 27 Oct
 2006 20:56:02 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 7BAE28003E1; Fri, 27 Oct 2006 20:56:00 +0200 (CEST)
To: Ben Clifford <benc@hawaga.org.uk>
Sender: git-owner@vger.kernel.org

fredag 27 oktober 2006 12:01 skrev Ben Clifford:
> On Thu, 26 Oct 2006, Robin Rosenberg wrote:
> > Of course you will read and understand this code. I don't know how good
> > an idea it is to use the DEBUG trap this way.
>
> I set my prompt without using it, with something approximating this
> being defined in my .bash_profile. I think the use of ' instead of "
> causes evaluation of __prompt_githead be delayed until the prompt is
> displayed.

Ahh, ofcourse. Thanks.

