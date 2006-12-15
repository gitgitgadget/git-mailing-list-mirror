X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 17:37:24 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612151736470.18171@xanadu.home>
References: <200612132200.41420.andyparkins@gmail.com>
 <20061213225627.GC32568@spearce.org>
 <200612140908.36952.andyparkins@gmail.com>
 <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
 <fcaeb9bf0612140708w6bc691f6k2e08fbab2a651421@mail.gmail.com>
 <Pine.LNX.4.63.0612141630240.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0612140832v1c80bf7dgd61897111292d31@mail.gmail.com>
 <Pine.LNX.4.63.0612141754420.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0612140910t6aff44e1m9570b20850a41b87@mail.gmail.com>
 <Pine.LNX.4.63.0612150118190.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0612150726o40527552l8b3564ddcc3adb94@mail.gmail.com>
 <Pine.LNX.4.63.0612152115000.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612152117390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ccomdc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 22:37:52 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7v64ccomdc.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34568>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvLgW-0003Xb-Rz for gcvg-git@gmane.org; Fri, 15 Dec
 2006 23:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752187AbWLOWhm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 17:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbWLOWhl
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 17:37:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47029 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752187AbWLOWhl (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 17:37:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAC006DL6UC9SI0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Fri,
 15 Dec 2006 17:37:24 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 15 Dec 2006, Junio C Hamano wrote:

>  * we add 'git ls' command to give Porcelain-ish access to
>    ls-tree and ls-files.

That seems the most sensible to me.


