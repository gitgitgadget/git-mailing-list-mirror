From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: [PATCH 3/3] Remove definition of refspec and pathspec
 from glossary-content.txt
Date: Tue, 02 Apr 2013 10:23:29 -0700
Message-ID: <7vwqsketim.fsf@alter.siamese.dyndns.org>
References: <7vy5d0gbkj.fsf@alter.siamese.dyndns.org>
 <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
 <1622068154.727718.1364894924364.JavaMail.ngmail@webmail14.arcor-online.net>
 <1741446121.741075.1364922350572.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:24:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4wH-0004jM-EM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899Ab3DBRXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:23:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761340Ab3DBRXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:23:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 458641296A;
	Tue,  2 Apr 2013 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LpgRzwDYTkrbmCsFpbzSEvev4fY=; b=pmauH2
	0bFivg/Byth3JJTvBaiPd4Ovw07Su/Byl8YO+eAv6UGvsoNFQRDe7JsmuKTdcjKr
	+astcUm7oxD1Ls3rYeprxBtFB3V6nk4z97aYPtK5Tm2gqYwmAB8CkALdyRM7qr8G
	RIf+Yr8no/vNImXQqU2GB/x4H1CgpSZDjcKBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dNZwJcdz+DuXU5beNMgxztVC8wQCQKgI
	4qFLPZBlE6HjZkrdyyINFvwTPe84NrsxdS3gGCWk4AdY/Um2qC61QUf/jtdleFwK
	GSaLamOTm6y+uGVQ315q5Otellfech4h8hhrDSojOtSfAclEdNRxvtD3htAepVcU
	rLKEhJdGXZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B26C12969;
	Tue,  2 Apr 2013 17:23:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 017A612968; Tue,  2 Apr
 2013 17:23:30 +0000 (UTC)
In-Reply-To: <1741446121.741075.1364922350572.JavaMail.ngmail@webmail15.arcor-online.net>
 (Thomas Ackermann's message of "Tue, 2 Apr 2013 19:05:50 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A187D12-9BBA-11E2-B379-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219808>

Thomas Ackermann <th.acker@arcor.de> writes:

>  
>> 
>> I think we can just drop "See ... for details" from here.  Besides,
>> why just "push" and not "fetch"?
>> 
>
> I just kept the original reference which only linked to git-push.

That is only because the last example the "See ... for details"
refers to is about 'git push', isn't it?
