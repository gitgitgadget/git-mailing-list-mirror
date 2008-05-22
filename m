From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/4] Implement normalize_absolute_path
Date: Thu, 22 May 2008 14:48:54 +0200
Message-ID: <20080522124854.GC3206@steel.home>
References: <48327456.1060202@facebook.com> <20080520222447.GA13123@steel.home> <4833DE89.4000106@facebook.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Thu May 22 14:49:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzAEy-00056w-EO
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 14:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761691AbYEVMs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 08:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761097AbYEVMs7
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 08:48:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:11601 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760945AbYEVMs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 08:48:58 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMna1s/dNSK
Received: from tigra.home (Fa855.f.strato-dslnet.de [195.4.168.85])
	by post.webmailer.de (klopstock mo41) (RZmta 16.38)
	with ESMTP id i027edk4MC3PAI ; Thu, 22 May 2008 14:48:55 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 013E6277BD;
	Thu, 22 May 2008 14:48:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2A29656D28; Thu, 22 May 2008 14:48:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4833DE89.4000106@facebook.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82621>

David Reiss, Wed, May 21, 2008 10:34:17 +0200:
> This is close enough to what I want that I could definitely use it if it
> were in the main tree.  I read through most of that thread, but I
> couldn't figure out what ever happened to your patch.  (I couldn't find
> a clear rejection, but I also don't see it in master.)

Me too. OTOH, it was not a clear proposal for inclusion.
