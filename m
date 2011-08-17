From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout-index: remove obsolete comment
Date: Wed, 17 Aug 2011 10:40:14 -0700
Message-ID: <7v62lwey2p.fsf@alter.siamese.dyndns.org>
References: <1313583733-7514-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 19:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtk6K-0006H0-3n
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 19:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab1HQRkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 13:40:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab1HQRkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 13:40:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B31C84EB4;
	Wed, 17 Aug 2011 13:40:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t9Kh7zt2MDyJXVyVB6u5Hil+LHA=; b=dnzlAi
	qu5bp+prEHIryL12NuiTMK003EFMxKbUZdPKx1QoWgskluFDKjS3+q6fW5aODR3g
	x9iDb1aEGyTy35bo/YOziARQPc3+17cstOvupMUCSUzohpsW6QNqi+VFoKzXTKXD
	XC9wmg9wpHUpBsyD4Z5A37HJkmR9/xGI2jfis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CncRvdw2NpjI+/3kGvY/7wKxNldgEcUy
	FBvg8ZvV+5VsMIyCY4GA+cdfgoX0Y25+aUmgYsOb/az3+cUQ7JrEQ3RGyElyPFYf
	KgapULHnN0pFSIHq3bOtzyplR1mcFWkU5kppIAvz7rfgkbHKasSnvEGRTKK/SEiq
	e948Al9hAms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB8774EB3;
	Wed, 17 Aug 2011 13:40:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41D034EB2; Wed, 17 Aug 2011
 13:40:16 -0400 (EDT)
In-Reply-To: <1313583733-7514-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 17 Aug
 2011 19:22:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7E86F3A-C8F7-11E0-B74F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179520>

Thanks; this will go traight to 'maint'.
