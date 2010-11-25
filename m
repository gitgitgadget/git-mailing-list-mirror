From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Thu, 25 Nov 2010 20:54:18 +0100
Message-ID: <m2zksxch79.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
	<1290517990.10366.17.camel@drew-northup.unet.maine.edu>
	<4CEBC8C9.4010905@drmicha.warpmail.net> <m2d3pwj8th.fsf@gmail.com>
	<1290532016.10892.40.camel@drew-northup.unet.maine.edu>
	<m2fwur7olt.fsf@gmail.com> <7v7hg2ttty.fsf@alter.siamese.dyndns.org>
	<4CEE1A99.8020001@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: git@drmicha.warpmail.net
X-From: git-owner@vger.kernel.org Thu Nov 25 20:55:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLhug-0002V6-Ky
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 20:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab0KYTy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 14:54:26 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42534 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab0KYTyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 14:54:25 -0500
Received: by wyb28 with SMTP id 28so1207157wyb.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 11:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=wWTRAm9R8qEOccAQGeQHBkHFS0SzVr1nfvLqTJ7o2Vw=;
        b=h+Lc1MxRxpETxpqIqXXzGs2kxaeiXJLUNTqYzOE102silNdvoLxBJZAv8QNqFBopI3
         1n7pdpwXBLax4pFdnEkuE4kX1vWv4DRc0SQ6/Q/LzY4Vgop+oA2I3qcxM0xaXZ23Ewhx
         c/ERDjH8B/zJT1dkdgLlb2zvlB/Rpm6DXxAxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=vun0GRZCuvLegMc8ikveyll4+h5ZB2gTe409D9X0gy+ttTbIjMFKC5CTGKFxhDxTJt
         1nu/atz75LKCxtUYx6xUpFnPOde61ZZaXWSt70OmezozE2Tpg0l8wLW4XxH+vWbtrlIU
         Vv7BtsvjKknGsoyHa1EhfTh1BDkXVCXu726yY=
Received: by 10.227.63.7 with SMTP id z7mr1410948wbh.21.1290714864195;
        Thu, 25 Nov 2010 11:54:24 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id q18sm598226wbe.23.2010.11.25.11.54.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 11:54:21 -0800 (PST)
In-Reply-To: <4CEE1A99.8020001@drmicha.warpmail.net>
	(git@drmicha.warpmail.net's message of "Thu, 25 Nov 2010 09:13:13
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162153>

git@drmicha.warpmail.net writes:

[...]

> Francis: If you can reproduce this in any way then please file a Fedora
> bug, or describe the procedure and I'll file a bug on your behalf.

Yes, I'll do.

-- 
Francis
