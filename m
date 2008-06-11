From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Wed, 11 Jun 2008 23:34:44 +0200
Message-ID: <20080611213444.GA14753@steel.home>
References: <20080611182501.GA3344@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 23:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Xyn-0006ia-GU
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYFKVer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYFKVer
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:34:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:59439 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYFKVeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:34:46 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarZw4lQg
Received: from tigra.home (Fae0e.f.strato-dslnet.de [195.4.174.14])
	by post.webmailer.de (fruni mo1) (RZmta 16.42)
	with ESMTP id e06654k5BLCQbE ; Wed, 11 Jun 2008 23:34:45 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CF28C277BD;
	Wed, 11 Jun 2008 23:34:44 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A4BC356D28; Wed, 11 Jun 2008 23:34:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080611182501.GA3344@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84667>

Alex Riesen, Wed, Jun 11, 2008 20:25:01 +0200:
> --- /dev/null
> +++ b/test-tr.c
> @@ -0,0 +1,206 @@
> +/*
> +vim: sw=8
> +*/

Sorry about that...
