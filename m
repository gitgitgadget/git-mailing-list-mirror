From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/10] color and pager improvements
Date: Thu, 18 Aug 2011 15:02:34 -0700
Message-ID: <7vpqk27400.fsf@alter.siamese.dyndns.org>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:24:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuB0V-0003Jb-9v
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab1HRWYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:24:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964Ab1HRWYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:24:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1C934364;
	Thu, 18 Aug 2011 18:24:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=kk+8Pu4M1VDNr3rkzFfV55OSG1Y=; b=Wrp+5MfVW5Gu3jKzbG3h
	yJvt/3YtwkLXGOHtYw6ZLIcpoDL7heLuREyCFRJGsW8515bflBTOBITrnHd5Yqfg
	CohDHxPJzSYUuOoi5Vqqel+vB3WiihZD4aqJvcDNby0plGMfwpQMHNLU2W8OVAZ1
	Q25qNAyqx24FM8VQrev67yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HOCtj3sGkF/sFHE8ObAoMgZYDPdVDJhETIKA2lkYqXRxwH
	V3BdrkKcsGBDrqvZlLfmifdeg2/K8gGZIoQT8VuuuUQzcyhgn0n0VnfSVQxgsLLe
	ORii74U+3kBjUrTjeqkZHXF+M3Vu1rzZZLyHMxZs0BoKtIBEz+ohBnszWhccw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFF524362;
	Thu, 18 Aug 2011 18:24:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52F794361; Thu, 18 Aug 2011
 18:24:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C57539A6-C9E8-11E0-BA40-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179644>

Nicely done.
