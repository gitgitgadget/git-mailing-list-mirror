From: Sergei Organov <osv@javad.com>
Subject: Re: Bug in git-show-branch, or in core-tutorial?
Date: Thu, 01 Nov 2007 15:11:42 +0300
Message-ID: <87zlxy2mip.fsf@osv.gnss.ru>
References: <878x5j3uos.fsf@osv.gnss.ru>
	<7v8x5ictrx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 13:12:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYuZ-0002IN-M7
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926AbXKAMMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756141AbXKAMMH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:12:07 -0400
Received: from javad.com ([216.122.176.236]:4565 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754913AbXKAMMG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:12:06 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA1CBmm37680;
	Thu, 1 Nov 2007 12:11:48 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1InYti-0000yP-W2; Thu, 01 Nov 2007 15:11:42 +0300
In-Reply-To: <7v8x5ictrx.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 01 Nov 2007 00\:24\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62946>

Junio C Hamano <gitster@pobox.com> writes:

> I think that is a simple typo of "these", not "three".

No, the explanation text explicitly mentions merge~1 revision that is
not there in the git-show-branch output, so those "three" is consistent
with explanation text itself, but not with git-show-branch output.

-- 
Sergei.
