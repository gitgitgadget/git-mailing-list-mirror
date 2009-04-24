From: Andy Lester <andy@petdance.com>
Subject: Re: [PATCH] Removed redundant static functions such as update_tracking_ref() and verify_remote_names() from builtin-send-pack.c, and made the ones in transport.c not be static so they can be used instead.
Date: Fri, 24 Apr 2009 16:13:14 -0500
Message-ID: <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com>
References: <1240546432-26212-1-git-send-email-andy@petdance.com> <20090424210418.GC13561@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:14:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxSjT-0000vp-NJ
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 23:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbZDXVNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 17:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754961AbZDXVNQ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 17:13:16 -0400
Received: from huggy.petdance.com ([72.14.176.61]:42615 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbZDXVNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 17:13:16 -0400
Received: from alester.flr.follett.com (host3130.follett.com [12.47.12.130])
	by huggy.petdance.com (Postfix) with ESMTP id C2C64AB54E;
	Fri, 24 Apr 2009 17:13:14 -0400 (EDT)
In-Reply-To: <20090424210418.GC13561@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117489>


On Apr 24, 2009, at 4:04 PM, Jeff King wrote:

> in git itself we usually use the imperative
> mood in commit mesages.


Boy, you guys are hardcore. :-)

This was what I was looking for.  I think what I'll do is fold your  
message into Documentation/SubmittingPatches and submit that as a  
patch first.

Thanks,
xoxo,
Andy

--
Andy Lester => andy@petdance.com => www.theworkinggeek.com => AIM:petdance
