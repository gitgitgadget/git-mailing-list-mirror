X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitk feature request..
Date: Sat, 11 Nov 2006 16:20:22 +0100
Organization: At home
Message-ID: <ej4pll$vo9$1@sea.gmane.org>
References: <452A37FB.60507@adelaide.edu.au> <17745.1213.22769.420355@cargo.ozlabs.ibm.com> <7vslgu28do.fsf@assigned-by-dhcp.cox.net> <e5bfff550611110708r1ad9559ewf35b8abaceb21cc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 11 Nov 2006 15:19:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31230>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Giudt-0006yc-Jc for gcvg-git@gmane.org; Sat, 11 Nov
 2006 16:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424008AbWKKPTd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 10:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424009AbWKKPTd
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 10:19:33 -0500
Received: from main.gmane.org ([80.91.229.2]:6124 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1424008AbWKKPTd (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 10:19:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Giudk-0006x7-2S for git@vger.kernel.org; Sat, 11 Nov 2006 16:19:28 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 16:19:28 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 11 Nov 2006
 16:19:28 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Marco Costalba wrote:

> Regarding the local / private views problem, perhaps we could use a
> local, i.e. out of .git directory, config file that _extends_ and
> _overrides_ the repository config file.

~/.gitconfig ? Since quite a bit of time, undocumented.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

