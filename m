X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: VCS comparison table
Date: Sun, 29 Oct 2006 00:18:04 +0200
Organization: Dewire
Message-ID: <200610290018.05884.robin.rosenberg.lists@dewire.com>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl> <m3mz7gheoe.fsf@iny.iki.fi> <ehvnal$tjg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 28 Oct 2006 22:17:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <ehvnal$tjg$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30400>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdwU8-0007t1-D3 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 00:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964867AbWJ1WQz convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWJ1WQz
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 18:16:55 -0400
Received: from [83.140.172.130] ([83.140.172.130]:16136 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S964867AbWJ1WQy convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006
 18:16:54 -0400
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 35B87802677; Sun, 29 Oct 2006 00:13:38 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 12365-03; Sun, 29 Oct
 2006 00:13:37 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id D561D8003E1; Sun, 29 Oct 2006 00:13:35 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

l=F6rdag 28 oktober 2006 15:53 skrev Jakub Narebski:
> But for example git(7) man page lists git commands clearly divided be=
tween
> low-level commands (plumbing): manipulation commands, interrogation
> commands, synching commands and high level commands (porcelain): main
> commands, ancillary commands. The "git help" and "git --help" shows t=
he
> most commonly used git commands with short description of each comman=
d
> ("git help -a" show all commands).

I believe people tend to skim through documentation looking for pieces =
of=20
information rather than read it from start to end. So they find themsel=
ves=20
reading the plumbing documentation first. Simply reordering documentati=
on to=20
list the porcelain commands before the plumbing would make the git man =
page=20
less scary to newcomers.

