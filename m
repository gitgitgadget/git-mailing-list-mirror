From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 02 Dec 2010 11:46:08 +0900
Message-ID: <87k4js51u7.fsf@catnip.gol.com>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
	<1291230820.11917.25.camel@drew-northup.unet.maine.edu>
	<877hftuvvz.fsf@picasso.cante.net>
	<7vfwuhtafr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 03:46:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNzBx-0002GT-RV
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 03:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800Ab0LBCqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 21:46:16 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:57319 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab0LBCqP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 21:46:15 -0500
Received: from 218.231.154.28.eo.eaccess.ne.jp ([218.231.154.28] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1PNzBR-0001Qf-L5; Thu, 02 Dec 2010 11:46:09 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id E3EE22175; Thu,  2 Dec 2010 11:46:08 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <7vfwuhtafr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 01 Dec 2010 14:06:32 -0800")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162664>

Junio C Hamano <gitster@pobox.com> writes:
> And "HEAD^" is shorter and much easier to type, and more importantly, it
> is more often used in the wild, so the readers of the documentation needs
> to know it anyway to understand what other people do.

Seriously:  People like ^.

This doc change is not good (and seems to demonstrate a lack of
familiarity with typical git usage)....

-Miles

-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
