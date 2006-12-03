X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to
 the index
Date: Sat, 02 Dec 2006 23:04:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612022302540.2630@xanadu.home>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home>
 <200612020828.57989.alan@chandlerfamily.org.uk>
 <87psb22qgu.wl%cworth@cworth.org>
 <200612021805.09143.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 3 Dec 2006 04:04:48 +0000 (UTC)
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612021805.09143.alan@chandlerfamily.org.uk>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33091>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqiar-0001Xh-75 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 05:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936653AbWLCEEa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 23:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936654AbWLCEEa
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 23:04:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:1582 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S936653AbWLCEE3 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 23:04:29 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9O0012YJBHXH40@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Sat,
 02 Dec 2006 23:04:29 -0500 (EST)
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

On Sat, 2 Dec 2006, Alan Chandler wrote:

> The argument I was _trying_ to make was that we should teach the second 
> conceptual model not the first one AND stick with just the git add command 
> (in response to your (Carl's) statement earlier in the thread that there 
> needs to be two separate commands) .  My if statements were to illustrate 
> that there are two fundamental ways of looking at this, not lots of ifs that 
> newbies would have to consider.  We should up-front (in the tutorial, in 
> appropriate man pages) use the one conceptual model (and I also like Junio's 
> argument that git should take an aggressive stance of this is how the 
> conceptual model is rather than the "contrary to ..." approach).

Agreed.


