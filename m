X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 17:37:25 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301736340.9647@xanadu.home>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home>
 <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org>
 <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
 <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
 <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
 <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
 <Pine.LNX.4.64.0611301253380.3513@woody.osdl.org> <eknhjr$nce$1@sea.gmane.org>
 <878xhsty3t.wl%cworth@cworth.org>
 <Pine.LNX.4.63.0611302324370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 22:37:32 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0611302324370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32820>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuX3-0007cK-Nl for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031588AbWK3Wh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031590AbWK3Wh1
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:37:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:247 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1031588AbWK3Wh0
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:37:26 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9K006E7EUD4Q90@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 30 Nov 2006 17:37:25 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 30 Nov 2006, Carl Worth wrote:
> 
> > It might even make sense to invent one more name for the case where
> > the user wants to inform git that a file has been edited and that git
> > should accept the new contents. It's the sort of "note that file is
> > edited" operation that could be recommended to the user with "add; fix
> > typo; commit" confusion.
> 
> I suggest "commit". How about this: after editing the file, you tell git 
> that you finished editing it by doing
> 
> 	git commit the-edited-file.txt
> 
> Hmmm?

Sure.  ;-)


