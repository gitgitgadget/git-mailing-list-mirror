X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 12:06:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141205490.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612132237.10051.andyparkins@gmail.com> <elpvro$rvj$1@sea.gmane.org>
 <200612140927.27259.andyparkins@gmail.com> <20061214093637.GC1747@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 17:06:55 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061214093637.GC1747@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34374>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guu2j-0005Bu-BG for gcvg-git@gmane.org; Thu, 14 Dec
 2006 18:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750960AbWLNRGq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 12:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWLNRGq
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 12:06:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21473 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750957AbWLNRGp (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 12:06:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA90024QWV8TVH0@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 12:06:44 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> But I'm not sure that git-add should output anything.  Last I checked
> the 'mv' command in Linux doesn't say "Move 5 files" when I move 5
> files into a directory.  Likewise I don't think that knowing that
> 6781 files were added is useful, what if it should have really been
> 6782 files?  I'm unlikely to know, care, or realize it.

git-add -v does output added files already.


