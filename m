From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Wed, 9 May 2007 09:56:02 -0400
Message-ID: <20070509135602.GB21489@thunk.org>
References: <4640FBDE.1000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 15:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlmet-0005up-Uo
	for gcvg-git@gmane.org; Wed, 09 May 2007 15:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbXEIN4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 09:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbXEIN4K
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 09:56:10 -0400
Received: from thunk.org ([69.25.196.29]:39690 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbXEIN4J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 09:56:09 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Hlml4-0001TD-I9; Wed, 09 May 2007 10:03:10 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HlmeA-00011q-II; Wed, 09 May 2007 09:56:02 -0400
Content-Disposition: inline
In-Reply-To: <4640FBDE.1000609@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46717>

I noticed that the patch didn't include additions to
Documentation/config.txt; could those be added, so that as much as
possible all of the various configuration knobs are documented in one
place, please?

Thanks!!

					- Ted
