From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 13 Jul 2010 23:01:17 -0400
Message-ID: <20100714030117.GA8658@maat.home>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
 <20100705192201.GI25518@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 14 05:01:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYsDv-0008WC-KC
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 05:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059Ab0GNDBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 23:01:22 -0400
Received: from josefsipek.net ([141.212.112.63]:39956 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237Ab0GNDBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 23:01:21 -0400
Received: by josefsipek.net (Postfix, from userid 108)
	id 2361B7EDB; Tue, 13 Jul 2010 23:01:21 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on odin.josefsipek.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable version=3.3.1
Received: from maat.home (unknown [141.212.213.226])
	by josefsipek.net (Postfix) with ESMTPSA id DAC0F287;
	Tue, 13 Jul 2010 23:01:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100705192201.GI25518@thunk.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150956>

FWIW, I pushed the change out.  I think this is a major enough fix that I'll
cut a new release soon.

Thanks!

Jeff.

-- 
The obvious mathematical breakthrough would be development of an easy way to
factor large prime numbers.
		- Bill Gates, The Road Ahead, pg. 265
