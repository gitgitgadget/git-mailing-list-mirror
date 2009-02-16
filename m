From: "Alfred M\. Szmidt" <ams@gnu.org>
Subject: Re: git-svn -- out of memory
Date: Mon, 16 Feb 2009 15:52:17 +0100
Message-ID: <1234795937.845716.4397.nullmailer@beryx.hq.kred>
Reply-To: ams@gnu.org
Cc: gitster@pobox.com, normalperson@yhbt.net, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 15:53:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ4r0-0000nk-0e
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 15:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbZBPOwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 09:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbZBPOwW
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 09:52:22 -0500
Received: from hq.kreditor.se ([213.136.42.58]:1136 "EHLO auxid.hq.kred"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750838AbZBPOwV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 09:52:21 -0500
Received: by auxid.hq.kred (Postfix, from userid 118)
	id A3BFD13795B1; Mon, 16 Feb 2009 15:52:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on auxid.hq.kred
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb
Received: from beryx.hq.kred (unknown [10.16.0.106])
	by auxid.hq.kred (Postfix) with SMTP id 915911379507;
	Mon, 16 Feb 2009 15:52:20 +0100 (CET)
Received: (nullmailer pid 4398 invoked by uid 1000);
	Mon, 16 Feb 2009 14:52:17 -0000
In-reply-to: message from Jeff King on Mon, 16 Feb 2009 08:45:06 -0500
References: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110186>

Added an extra 20G of swap, still the same error.
