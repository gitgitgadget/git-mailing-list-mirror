From: "David E. Wheeler" <david@justatheory.com>
Subject: Re: Wither --local
Date: Thu, 26 Apr 2012 12:09:34 -0700
Message-ID: <043D06DF-BF0C-4919-B787-601A93C8BD33@justatheory.com>
References: <799127EF-097F-41DA-A331-E38968ED531D@justatheory.com>
 <20120425214300.GB8590@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 21:09:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNU4d-0000GN-1w
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 21:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540Ab2DZTJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 15:09:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab2DZTJi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 15:09:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D4A27F99;
	Thu, 26 Apr 2012 15:09:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject
	:mime-version:content-type:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=sasl; bh=
	3B0wNDhaTFky59aOs2DmXOZ/2/o=; b=Qjh7vYcY9AfqHKCnPghJem2343EcyVXk
	raGnMTrJpp5XYkmlAKgx7U6m73gX4/1EiAQbxljOtx4WRURQCRIgqXSnkXCjFcz/
	BHeCbSWOs4ftyruHrsgT13XYtodFfQMy1pIvHBAfUDa3hQ1o8OKGHCwnWT2IcTqw
	Zh0oZL5Iv6M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1438D7F98;
	Thu, 26 Apr 2012 15:09:37 -0400 (EDT)
Received: from hydrogen.iovation.com (unknown [74.121.28.6]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DF3A7F91; Thu, 26 Apr 2012
 15:09:35 -0400 (EDT)
In-Reply-To: <20120425214300.GB8590@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1257)
X-Pobox-Relay-ID: 5CF39628-8FD3-11E1-9C2D-FC762E706CDE-76319746!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196393>

On Apr 25, 2012, at 2:43 PM, Jeff King wrote:

>> I notice that the usage statement displayed for `git config` mention=
s
>> --local, but `git help config` does not. Should it? It seems a bit
>> under-documented=85
>=20
> Yes, it should. Original motivation is here:
>=20
>  http://thread.gmane.org/gmane.comp.version-control.git/152524

Is this thread sufficient to get it on someone's radar, or should there=
 be a ticket somewhere?

Thanks,

David
