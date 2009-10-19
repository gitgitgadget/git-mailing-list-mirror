From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: clean block-sha1/ directory instead of
 mozilla-sha1/
Date: Sun, 18 Oct 2009 22:58:41 -0700
Message-ID: <7vzl7n7wmm.fsf@alter.siamese.dyndns.org>
References: <20091011133219.GA28070@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Carlos R. Mafra" <crmafra@aei.mpg.de>
X-From: git-owner@vger.kernel.org Mon Oct 19 07:59:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzlGg-0004xG-Ei
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 07:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbZJSF6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 01:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbZJSF6o
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 01:58:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbZJSF6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 01:58:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D045E2D3;
	Mon, 19 Oct 2009 01:58:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=44zXNQSDctEP6RwxaD6gxidinTs=; b=YzQLI/KRSwf8vJhq4W/65Bx
	c6newQf9X19V+hmnqST+5iQDM193lTj5kpNoHeo45znoljPrJLiEVD7ZUhs9OSDH
	4QAn6AZ3iu44D8R3ThJUpgyJveT+bLLEns+X60S7LSbeNcjo1FPTggTaGbJ/Mrl+
	tjpjp4p/4eDsngSKMMRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kcs+hh1cpWRybEvgQWbJsm7ecSbdB6JtKukG+3qk65c/wm/tr
	ubNsj2i1SYWb8oRoM3Rggyd6oTz4GJ4QrK82WsNoVwyhyAndC6VR3vRk3i15QxAV
	+aqlg/xpcYvex/Tte1tVmm5F7HlV4OwuQPGdhlJ3D/Df1gRNy04BXe21KY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EAA615E2D2;
	Mon, 19 Oct 2009 01:58:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D66E5E2D1; Mon, 19 Oct
 2009 01:58:43 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 768F0098-BC74-11DE-B947-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130654>

Thanks, applied.
