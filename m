X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: shallow clones, was Re: What's cooking in git.git (topics)
Date: Thu, 07 Dec 2006 17:44:46 +0100
Message-ID: <874ps77j0h.fsf@wine.dyndns.org>
References: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612070035570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<87zma06ptm.fsf@wine.dyndns.org>
	<Pine.LNX.4.63.0612071557580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 16:45:13 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612071557580.28348@wbgn013.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Thu\, 7 Dec 2006 15\:59\:39 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33599>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsMMh-0003jZ-TR for gcvg-git@gmane.org; Thu, 07 Dec
 2006 17:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032395AbWLGQow (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 11:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032399AbWLGQow
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 11:44:52 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:55572 "EHLO
 mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1032395AbWLGQov (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 11:44:51 -0500
Received: from adsl-84-227-138-209.adslplus.ch ([84.227.138.209]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GsMMa-0004eA-SY; Thu, 07
 Dec 2006 10:44:49 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 51B6F4F672; Thu, 
 7 Dec 2006 17:44:46 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sorry, I was just mumbling about the fact that I would _like_ to hear back 
> about successes and failures. If there are problems I want to fix them.
>
> So, do you actually know of people who _used_ (as opposed to "tested") 
> shallow clones?

No, I'm afraid not. Unfortunately, using it requires an upgraded
server, and I'm reluctant to put an experimental release on the main
Wine server, so I was kind of waiting for it to graduate to master. Of
course that's a bit of a chicken and egg problem...

-- 
Alexandre Julliard
