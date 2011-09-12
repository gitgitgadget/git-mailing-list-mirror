From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 16:35:18 -0700
Message-ID: <7vlitt1gi1.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vk49d5t8u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 01:35:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3G29-0006Gf-TV
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab1ILXfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:35:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755559Ab1ILXfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:35:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5135F4F33;
	Mon, 12 Sep 2011 19:35:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8p/3rIjh/bLh7PGdcL8MCqqGGRA=; b=cYOm0O
	qGGLCd49R2b3rPaSeZaynKkkGBCIfm3X3MTampDDhcn0HfNUbwG9+2+8NlHlzIVx
	cd8UnbOiMF4wp8LHlg59BxD247HQ9ZcqdUnXiS9xjlEvmDnAP9zUasUHJkA8mk6N
	YAcySFPpS5SmjaHc+a6ZEr+w+u80Yb/8YC79E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TVuI+wz+BeOUjQd1rVi2unEgtekMF7b4
	oIenYFsnEm/pbymqyKk2jrSZkiAq9pLFnPfZfWy4oTFpTnQ4nu4wocjkioHs3iy6
	9SR8e0uOgU9sF/cZS8OSUAUxvyqHxwYetCFzYOumguTbUkBdo1HGSUahPBUC+yoe
	oiCIRV8QxMw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47E344F32;
	Mon, 12 Sep 2011 19:35:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD0674F31; Mon, 12 Sep 2011
 19:35:19 -0400 (EDT)
In-Reply-To: <7vk49d5t8u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 12 Sep 2011 14:46:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E087131E-DD97-11E0-9B18-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181260>

[resending to the list as I screwed-up the To/Cc: header in the original]

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * jk/default-attr (2011-08-26) 1 commit
>  - attr: map builtin userdiff drivers to well-known extensions
>
> Not urgent; I fixed up the test breakage just for fun.

Could people who participated in the discussion make sure what is queued
includes their favorite extensions they proposed?

Thanks.
