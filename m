From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: Emacs git-mode feature request: support fill-paragraph correctly
Date: Thu, 29 Jan 2009 11:42:10 +0100
Message-ID: <87tz7i4cn1.fsf@wine.dyndns.org>
References: <87tz7mth3g.fsf@write-only.cryp.to>
	<873af59fkm.fsf@wine.dyndns.org> <878wow7sgx.fsf@write-only.cryp.to>
	<7vk58fktfy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 11:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSUNC-0004UT-CB
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 11:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZA2KmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 05:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbZA2KmW
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 05:42:22 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:51028 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZA2KmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 05:42:21 -0500
Received: from adsl-84-227-43-63.adslplus.ch ([84.227.43.63] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LSULc-00028d-V2; Thu, 29 Jan 2009 04:42:19 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7AF271E71F0; Thu, 29 Jan 2009 11:42:10 +0100 (CET)
In-Reply-To: <7vk58fktfy.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 28 Jan 2009 13:32:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107654>

Junio C Hamano <gitster@pobox.com> writes:

> Peter Simons <simons@cryp.to> writes:
>
>> that patch has the desired effect (tested with GNU Emacs 22.3.1 and
>> GIT 1.6.1). Thank you very much.
>>
>> Now, I'd be hugely in favor of applying that change to the repository
>> so that future versions of GIT have it.
>
> Alexandre?

Sure, I'll include it in my next pull request.

-- 
Alexandre Julliard
julliard@winehq.org
