X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Author name and e-mail address in .stgitrc
Date: Sat, 11 Nov 2006 15:31:15 +0100
Organization: Dewire
Message-ID: <200611111531.16304.robin.rosenberg.lists@dewire.com>
References: <20061111113553.GA11224@diana.vm.bytemark.co.uk> <20061111141530.GF11224@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 14:30:00 +0000 (UTC)
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061111141530.GF11224@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31225>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gitro-0006Hf-JZ for gcvg-git@gmane.org; Sat, 11 Nov
 2006 15:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947252AbWKKO3n convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 09:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947254AbWKKO3n
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 09:29:43 -0500
Received: from [83.140.172.130] ([83.140.172.130]:45329 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1947252AbWKKO3m convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006
 09:29:42 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 76DAF8027E4; Sat, 11 Nov 2006 15:26:14 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 26415-07; Sat, 11 Nov
 2006 15:26:14 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 2E6FD802654; Sat, 11 Nov 2006 15:26:12 +0100 (CET)
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

l=F6rdag 11 november 2006 15:15 skrev Karl Hasselstr=F6m:
> Is there any particular reason to have the author and committer names
> in ~/.stgitrc? Simply taking them from the same place git does would
> probably be a usability enhancement (unless they're specified on the
> command line, of course).

AFAIK StGit already does that, at least if you (like me) do not have=20
a .stgitrc.

