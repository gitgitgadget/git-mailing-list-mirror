From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with NO_NORETURN
Date: Tue, 21 Jun 2011 00:33:22 +0200
Message-ID: <20110620223322.GF32765@one.firstfloor.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org> <1308445625-30667-2-git-send-email-andi@firstfloor.org> <7vsjr4b3tf.fsf@alter.siamese.dyndns.org> <7vk4cgb24p.fsf@alter.siamese.dyndns.org> <20110620220027.GD32765@one.firstfloor.org> <7vboxsb0f3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:33:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYn2A-0005DO-IS
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 00:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab1FTWd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 18:33:26 -0400
Received: from one.firstfloor.org ([213.235.205.2]:41964 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab1FTWdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 18:33:25 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 515971A980FA; Tue, 21 Jun 2011 00:33:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vboxsb0f3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176103>

> I am inclined to apply only 1 and 3, which is what I already have on 'pu'.

Thanks. 

I guess should add some documentation that explains that there
are additional warnings (and some general pointers). I'll send that
in another patch.

-Andi
> 

-- 
ak@linux.intel.com -- Speaking for myself only.
