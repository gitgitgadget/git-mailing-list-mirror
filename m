X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-explain
Date: Tue, 05 Dec 2006 20:50:45 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612052050190.2630@xanadu.home>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
 <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
 <7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
 <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net> <el3ibq$9kn$2@sea.gmane.org>
 <46a038f90612051500w44438f70y3c7d1c99998d16bb@mail.gmail.com>
 <7vslfudjsa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612060033540.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu009dhgz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612060125320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 6 Dec 2006 01:50:57 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0612060125320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33399>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grlvu-0005YT-5v for gcvg-git@gmane.org; Wed, 06 Dec
 2006 02:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759625AbWLFBur (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 20:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759634AbWLFBur
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 20:50:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14180 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759625AbWLFBuq (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 20:50:46 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9T000J5X4LUU50@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Tue,
 05 Dec 2006 20:50:45 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Wed, 6 Dec 2006, Johannes Schindelin wrote:

> In this spirit, maybe it is time to enable reflog per default?

Definitely.


