From: Erik de Castro Lopo <mle+tools@mega-nerd.com>
Subject: Re: Retrieving a file at a before a specified commit
Date: Thu, 30 May 2013 13:18:21 +1000
Organization: Erik Conspiracy Secret Labs
Message-ID: <20130530131821.594bc05666fa3ea17b55dffc@mega-nerd.com>
References: <20130529164735.5489ab47953406745d9034ef@mega-nerd.com>
	<20130529075811.GA7204@sigill.intra.peff.net>
	<20130530104932.d7ba4bfb426044ab9653057e@mega-nerd.com>
	<20130530105956.dbf5e3363fa0abbc0143d463@mega-nerd.com>
	<7vobbtp5h5.fsf@alter.siamese.dyndns.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 05:18:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhtNk-0006tI-NV
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 05:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967366Ab3E3DSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 23:18:24 -0400
Received: from hendrix.mega-nerd.net ([203.206.230.162]:39636 "EHLO
	hendrix.mega-nerd.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967322Ab3E3DSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 23:18:23 -0400
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
	by hendrix.mega-nerd.net (Postfix) with SMTP id D7B6A106DF9
	for <git@vger.kernel.org>; Thu, 30 May 2013 13:18:21 +1000 (EST)
In-Reply-To: <7vobbtp5h5.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225918>

Junio C Hamano wrote:

> While you are at it, you may want to check your LESS environment
> variable settings, especially if you find that the command gives you
> control without showing anything for a small (not zero length) file.

Thanks. Thats a good tip. In my case LESS was not set to anything.

Cheers,
Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
