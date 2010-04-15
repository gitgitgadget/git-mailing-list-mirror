From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v3] Replace hard-coded path with one from <paths.h>
Date: Thu, 15 Apr 2010 14:01:01 +0100
Message-ID: <20100415130101.GJ12365@arachsys.com>
References: <20100406163643.GG15306@arachsys.com>
 <m3hbncgaxu.fsf@localhost.localdomain>
 <20100415124043.GH12365@arachsys.com>
 <201004151458.02156.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 15:01:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Oh0-0006zT-14
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 15:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab0DONBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 09:01:06 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:49993 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab0DONBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 09:01:05 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2Ogo-00054x-Qe; Thu, 15 Apr 2010 14:01:03 +0100
Content-Disposition: inline
In-Reply-To: <201004151458.02156.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144983>

Jakub Narebski <jnareb@gmail.com> writes:

> Well, there is only one example of checking for _headers_, namely
> NO_LIBGEN_H, so it is not that you are against some majority.
> 
> In short: if there is no voice against HAVE_PATHS_H, lets have it this
> way.

Okay, sounds good to me. I'll respin with the style changes you suggested.

Best wishes,

Chris.
