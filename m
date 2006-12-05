X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] git-explain
Date: Mon, 4 Dec 2006 22:57:21 -0500
Message-ID: <20061205035721.GA26735@fieldses.org>
References: <200612031701.15594.alan@chandlerfamily.org.uk> <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org> <7v1wngwws6.fsf@assigned-by-dhcp.cox.net> <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612042253250.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 03:57:34 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612042253250.2630@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33296>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrRQw-0002xi-C5 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 04:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968070AbWLED51 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 22:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968076AbWLED51
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 22:57:27 -0500
Received: from mail.fieldses.org ([66.93.2.214]:53464 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968070AbWLED51 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 22:57:27 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GrRQn-0001Vu-9v; Mon, 04 Dec 2006
 22:57:21 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

On Mon, Dec 04, 2006 at 10:55:49PM -0500, Nicolas Pitre wrote:
> On Mon, 4 Dec 2006, Junio C Hamano wrote:
> 
> > [PATCH] git-explain
> > 
> > This patch adds "git-explain" script that notices various clues
> > other commands can leave the working tree and repository in and
> > intended to guide the end user out of the confused mess.
> 
> What about calling it git-whatsup instead?

No, clearly it should be git-wtf.

