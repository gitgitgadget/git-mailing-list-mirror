From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] fast-import: Fix compile warnings
Date: Wed, 07 Feb 2007 09:47:29 -0800
Message-ID: <7vveid7tce.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702071237360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzm7p7uf9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702071829450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 18:47:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqtR-0003vE-2F
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbXBGRrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 12:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161407AbXBGRrh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:47:37 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35919 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161403AbXBGRrg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 12:47:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207174736.LOVL1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 12:47:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LhnV1W0171kojtg0000000; Wed, 07 Feb 2007 12:47:30 -0500
In-Reply-To: <Pine.LNX.4.63.0702071829450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 7 Feb 2007 18:35:30 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38950>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> However, your patch does not apply.
>
> Hmm. Strange, I thought that I only changed the in_merge_bases() line... 
> Will have a look tomorrow.

Sorry, but not to worry.  It was because Shawn had a few updates
ahead of you.
