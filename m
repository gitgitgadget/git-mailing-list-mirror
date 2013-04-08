From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] remote-bzr: generic updates
Date: Mon, 08 Apr 2013 12:00:27 -0700
Message-ID: <7vsj30x2yc.fsf@alter.siamese.dyndns.org>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
 <7v1uakyj30.fsf@alter.siamese.dyndns.org>
 <CAMP44s1WXpNaPXd+fGm4_oFQEFf_Sjq1PsHUn2XjtfMebY2PHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:00:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHIx-0004Oa-1R
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935661Ab3DHTAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:00:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935135Ab3DHTAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:00:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3922A14B5B;
	Mon,  8 Apr 2013 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oAGSDkdM2fliF9sy3dX5mOPpEMY=; b=JCgR+h
	V1eKCCeLrg1QH+KatZ/KITqFf/EgdzKENgc/i6j1ZnAJtNFJ77x5wju0QVVeLqAf
	TmNqNvUj5DDHbGNs57PyXDUvVUcJpa2JRSl3o/QoFIGa+yEbQI50Hd8Z6fj9LhdJ
	46Fp7pysacEely5J1iMO8aAKxZqc/B9oHDNUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f0hpy/VSZq9vJinIz/TqjCU28IC8wumu
	R6CZKhurrMOrr1Q0nWajQ9etAjK0j0ulX26wo2Y9QgJ3kQPq01ON24eKmWyr/1Sg
	OmD9tRbk+4yevX2vuUpIx33EC+IGt0ud3vjqVimk/yEiYvKWAeFXwDaKG5AnvYRf
	EC3aBWI3k1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D72E14B59;
	Mon,  8 Apr 2013 19:00:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D5F014B58; Mon,  8 Apr
 2013 19:00:28 +0000 (UTC)
In-Reply-To: <CAMP44s1WXpNaPXd+fGm4_oFQEFf_Sjq1PsHUn2XjtfMebY2PHQ@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 8 Apr 2013 13:38:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94142CB4-A07E-11E2-B4D0-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220494>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Apr 8, 2013 at 1:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Oops.  The previous round is already now part of 'master'.
>
> All right, rebased and resent.

Thanks.
