X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: asciidoc, docbook, "book" doctype
Date: Sun, 10 Dec 2006 22:20:14 -0500
Message-ID: <20061211032013.GA16054@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 11 Dec 2006 03:20:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33973>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtbiG-0001yS-PQ for gcvg-git@gmane.org; Mon, 11 Dec
 2006 04:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759754AbWLKDUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 22:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762338AbWLKDUQ
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 22:20:16 -0500
Received: from mail.fieldses.org ([66.93.2.214]:45007 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759754AbWLKDUP (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 22:20:15 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GtbiA-0000J4-4s for
 git@vger.kernel.org; Sun, 10 Dec 2006 22:20:14 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I've been fooling around with producing a longer piece of documentation
using material from the tutorials, etc., using the docbook backend and
"book" doctype.  It's not working quite the way I'd expect.  For
example, it doesn't format the literal blocks correctly, and man page
links aren't producing useful clickable links.  Should I be going about
this some other way?

All I really want is automatically generated tables of contents and
cross-references.

