X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 11:31:43 +0100
Organization: Dewire
Message-ID: <200611031131.43490.robin.rosenberg.lists@dewire.com>
References: <20061101090046.1107.81105.stgit@localhost> <20061103100142.GD16721@diana.vm.bytemark.co.uk> <20061103102119.GO20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 10:36:21 +0000 (UTC)
Cc: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061103102119.GO20017@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30817>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfwP3-0002hx-8X for gcvg-git@gmane.org; Fri, 03 Nov
 2006 11:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753237AbWKCKeu convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 05:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbWKCKet
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 05:34:49 -0500
Received: from [83.140.172.130] ([83.140.172.130]:53595 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1753207AbWKCKeR convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 05:34:17
 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id AAA45802C0B; Fri,  3 Nov 2006 11:30:56 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 16377-10; Fri,  3 Nov
 2006 11:30:56 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5]) by torino.dewire.com (Postfix)
 with ESMTP id 6092A8027E4; Fri,  3 Nov 2006 11:30:56 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

fredag 03 november 2006 11:21 skrev Petr Baudis:
> Dear diary, on Fri, Nov 03, 2006 at 11:01:42AM CET, I got a letter
> where Karl Hasselstr=F6m <kha@treskal.com> said that...
>
> > On 2006-11-03 10:58:59 +0100, Karl Hasselstr=F6m wrote:
> > > I believe all the mails I send with mutt are QP-encoded,
> >
> > I just checked, and that one certainly was.
>
> Are you sure? As far as I can see, it's 8bit.

The patch mail was QP-encoded, not the other messasges in this thread.

