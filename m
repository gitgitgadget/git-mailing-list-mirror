X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Resolving conflicts
Date: Fri, 1 Dec 2006 08:13:40 +0000
Message-ID: <200612010813.41001.alan@chandlerfamily.org.uk>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302353580.3695@woody.osdl.org> <Pine.LNX.4.64.0611302359400.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 08:14:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0611302359400.3695@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32869>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq3Wm-0003wu-R8 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 09:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967496AbWLAINq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 03:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967497AbWLAINq
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 03:13:46 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:1159 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S967496AbWLAINp (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1
 Dec 2006 03:13:45 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gq3Wi-0007xi-LD for git@vger.kernel.org; Fri, 01 Dec 2006 08:13:44 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 01 December 2006 08:00, Linus Torvalds wrote:
> On Thu, 30 Nov 2006, Linus Torvalds wrote:
> > No, kdiff3 probably doesn't have the same semantics, so better get the
> > "real" merge. It's almost certainly in the rcs package, so "emerge rcs"
> > should do it.
>
> ..and just to be safe, remove the symlink first, so that you don't end up
> overwriting the "kdiff3" binary by mistake when you install the real
> "merge". Not that I think emerge is quite that stupid a package manager,
> but anyway..

Ubuntu is a Debian based.  I think it uses Synaptic as its package manager gui 
with the standard Debian apt-xxx tools underneath.
-- 
Alan Chandler
