From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] Pretty formats for reflog data
Date: Fri, 16 Oct 2009 17:50:41 -0700
Message-ID: <7vws2uonby.fsf@alter.siamese.dyndns.org>
References: <20091016053230.GB10629@coredump.intra.peff.net>
 <cover.1255701207.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Oct 17 02:51:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyxVf-0001c3-Kc
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 02:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbZJQAuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 20:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbZJQAuu
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 20:50:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbZJQAuu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 20:50:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 194085BA11;
	Fri, 16 Oct 2009 20:50:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JwfduBk41KAhfzMp3Hyl/HBAHHg=; b=WCar55fe2GWm0tX9ghNM4U0
	9oGsmVPu509VMHlyOSLUQKt4Q4kxSG3IRUYMtf5lVu7froOpijX2FzDeQrHNLB8a
	soEBiRagXnMHue+GTqnEzPsZY3ezh9Om0f0hANBx1UCXq346k5vOQCo5LiuISj7d
	AVrlPv34lNgbARSDxlRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=e5siNLEimGP6GL6BVPNrRuGKMrg9dj8yKtHU8L/y0pY3uwZmG
	xxuqlkFNliMG/7eKzn6FHdVxR1KWzsDmZVCmTPnnqAJikPnVDLHzIpBBuSROP6/q
	XQPoOmeiRfegZPGAZTSDTYg4C09cTyi6sH/k1y8402PH1B7RnqTrQi9Xyc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1C0F5BA0F;
	Fri, 16 Oct 2009 20:50:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E806A5BA0C; Fri, 16 Oct
 2009 20:50:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C7D1C3E-BAB7-11DE-8DA7-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130542>

Thomas Rast <trast@student.ethz.ch> writes:

> Next round :-)

Very nicely done; I like it.

Thanks.
