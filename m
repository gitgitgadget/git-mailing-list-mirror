From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 08:45:24 +0200
Message-ID: <20080814064524.GA4379@blimp.local>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 14 08:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTWcH-0002dB-FF
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 08:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758015AbYHNGpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 02:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758460AbYHNGpa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 02:45:30 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:47315 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757288AbYHNGp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 02:45:28 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r84hO89yw==
Received: from tigra.home (Fa869.f.strato-dslnet.de [195.4.168.105])
	by post.webmailer.de (mrclete mo58) (RZmta 16.47)
	with ESMTP id p03732k7E5RYOB ; Thu, 14 Aug 2008 08:45:25 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 2C10B277AE;
	Thu, 14 Aug 2008 08:45:25 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 01E3E36D1A; Thu, 14 Aug 2008 08:45:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218687684-11671-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92328>

Marcus Griep, Thu, Aug 14, 2008 06:21:24 +0200:
>  SYNOPSIS
>  --------
> -'git count-objects' [-v]
> +'git count-objects' [-v [-H]]
>  

GNU ls and du use "-h", with du using -H for SI units.
