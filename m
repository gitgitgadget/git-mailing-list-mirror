From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: [PATCH] Documentation: Use 'First Paragraph' instead of 'First
 Line'.
Date: Thu, 13 Sep 2012 16:20:35 -0500
Message-ID: <50524E23.2040507@codeweavers.com>
References: <5051D4A0.4060608@codeweavers.com> <7vehm593v8.fsf@alter.siamese.dyndns.org> <505248C3.7000803@codeweavers.com> <7vwqzx62vv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:20:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGq4-0008Nb-92
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab2IMVUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:20:36 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:47068 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab2IMVUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:20:35 -0400
Received: from jwhite.mn.codeweavers.com ([10.69.137.101] ident=jwhite)
	by mail.codeweavers.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <jwhite@codeweavers.com>)
	id 1TCGpv-0001wb-Ao; Thu, 13 Sep 2012 16:20:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <7vwqzx62vv.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205427>

>> I did not substantially alter this. The emphasis of this section
>> is on the broader show-branch output, and belaboring the subject would
>> be distracting and unnecessary imho.
> 
> Yeah, but if that is the focus of this part of the documentation,
> wouldn't a patch to update "the first line" with something more
> generic like "title of the commit" be more appropriate?

See my patch; I went with 'first part'.  That, I think, does not
mislead (the goal of my change), but also does not distract from
the main point of the section (detailing the various bits of
git show-branch).

Cheers,

Jeremy
