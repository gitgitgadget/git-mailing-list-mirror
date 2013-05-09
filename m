From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] transport-helper: trivial style cleanup
Date: Thu, 09 May 2013 16:03:37 -0700
Message-ID: <7vr4hf7o3a.fsf@alter.siamese.dyndns.org>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 01:03:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZsT-0001M6-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774Ab3EIXDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:03:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932148Ab3EIXDk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:03:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A83B1DE47;
	Thu,  9 May 2013 23:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H/sRVkLvj9tXeNFQlApDncUQ/uc=; b=WwLLAd
	h3nWYyHSb+cNzH8GTrl8xfXsJ0ZsFj7QUAkpoPfgpOXo7TvI7GIOKb+wToWGyGwf
	YF1VVv+t0cfNq4AJiqAT1nHLVW91FjrajJrZeTI9xNf67ALJM4vtGvQEC1KvPbDm
	5yiOCR7CYWmtpaLPhtWK+rFhTQpbCoPRWnEKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QCS8wx7F1rdJYqzse4m0CM0FISbmhUR4
	1Pj9oYl6dsbSD0vTAaIFNCfxFoZ+1yOhChJJEz13MvcKxzbSL4Fy8HmF1GNeupyP
	/eh2AAvXkrV7voJRS2G7IOIHCdYra8q17HC4QSFqYMqY8oTHwZvHND94lbddE87n
	24JrZPOJ5HI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F3A81DE46;
	Thu,  9 May 2013 23:03:39 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05D281DE44;
	Thu,  9 May 2013 23:03:38 +0000 (UTC)
In-Reply-To: <1368062218-22440-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 8 May 2013 20:16:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF821D3A-B8FC-11E2-86A2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223797>

Thanks; no brainer.
