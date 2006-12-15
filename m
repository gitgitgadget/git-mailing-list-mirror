X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 10:30:43 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612151029080.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <200612141136.59041.andyparkins@gmail.com> <eluemi$gc0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 15:30:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <eluemi$gc0$1@sea.gmane.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34517>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvF1L-0001tx-IG for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751925AbWLOPap (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbWLOPap
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:30:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11130 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751925AbWLOPao (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 10:30:44 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAB00CHVN37XOH0@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Fri,
 15 Dec 2006 10:30:43 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, 15 Dec 2006, Jakub Narebski wrote:

> It would be nice to have some generic place in git config to specify
> default options to git commands (at least for interactive shell). It
> cannot be done using aliases. Perhaps defaults.<command> config variable?

I would say the alias facility has to be fixed then.

In bash you can alias "ls" to "ls -l" and it just works.


