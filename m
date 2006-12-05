X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-explain
Date: Mon, 04 Dec 2006 22:55:49 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612042253250.2630@xanadu.home>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
 <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
 <7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
 <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 5 Dec 2006 03:56:00 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33295>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrRPN-0002ps-Qj for gcvg-git@gmane.org; Tue, 05 Dec
 2006 04:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966377AbWLEDzu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 22:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968067AbWLEDzu
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 22:55:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48016 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S966377AbWLEDzu (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 22:55:50 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9S00JEH891B630@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Mon,
 04 Dec 2006 22:55:49 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, 4 Dec 2006, Junio C Hamano wrote:

> [PATCH] git-explain
> 
> This patch adds "git-explain" script that notices various clues
> other commands can leave the working tree and repository in and
> intended to guide the end user out of the confused mess.

What about calling it git-whatsup instead?


