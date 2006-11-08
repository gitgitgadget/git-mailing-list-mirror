X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] gitweb: New improved patchset view
Date: Wed, 08 Nov 2006 10:27:15 -0800
Message-ID: <7virhpu73w.fsf@assigned-by-dhcp.cox.net>
References: <200611081147.52952.jnareb@gmail.com>
	<200611081150.07469.jnareb@gmail.com>
	<200611081758.57597.jnareb@gmail.com>
	<200611081759.41498.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 18:28:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611081759.41498.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 8 Nov 2006 17:59:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31150>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhsA2-0001j3-04 for gcvg-git@gmane.org; Wed, 08 Nov
 2006 19:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754646AbWKHS1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 13:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbWKHS1X
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 13:27:23 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30109 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1754646AbWKHS1R
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 13:27:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061108182716.MEZB9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 13:27:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kJTM1V0101kojtg0000000; Wed, 08 Nov 2006
 13:27:22 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> ---
>  gitweb/gitweb.css  |   66 +++++++++++++++----
>  gitweb/gitweb.perl |  183 
> ++++++++++++++++++++++++++++++++++------------------
>  2 files changed, 173 insertions(+), 76 deletions(-)

Linewrap?

> ----------------------------------------------------------------------
>  ## functions returning short HTML fragments, or transforming HTML 
> fragments

...
