From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git://github.com/some/thing.git/?
Date: Tue, 27 Mar 2012 11:54:58 -0700
Message-ID: <7v8vilj2m5.fsf@alter.siamese.dyndns.org>
References: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
 <20120327163339.GA5941@sigill.intra.peff.net>
 <7vd37xj3zh.fsf@alter.siamese.dyndns.org>
 <20120327183833.GB8460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:55:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCbY1-0001Mt-Er
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab2C0SzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 14:55:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755773Ab2C0SzF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:55:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 662BD71D2;
	Tue, 27 Mar 2012 14:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJDjHTUG+Yn1pfK2VdtU1dDX2BM=; b=Gyf9Fm
	9oKZb/ckuxHV0/EICv/qhBbK0ne23A0SIZear2Ydp7+cGfXFc8AmmtvWuyWz05gR
	RD1bJsqDwcechaMaU66aTJQgMzsYW+jjThhnenQIvA8stKnRCqt2SxS8hTzRMUBu
	LJ6siENGBsZnbEb9B0uL8U9jOypw3I3UjjK5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgUFquZHb/+khRJjp2s5HyWsH/Xsu9i8
	060fdEAyXMm/fNoCBpR35/jB3V5SltneMlRXtSIYYOHpnpOukHFuAdrPsIH78Tfh
	so4arq9ZXObmZD3Ew/cKn5zdIs3fVgUQPK/QdZFRd3to0p00XSTTvrAcURIt74CF
	eVnGFGGNgTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D7F771D1;
	Tue, 27 Mar 2012 14:55:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8522E71CC; Tue, 27 Mar 2012
 14:55:00 -0400 (EDT)
In-Reply-To: <20120327183833.GB8460@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 27 Mar 2012 14:38:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5ADCF2E6-783E-11E1-9E32-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194075>

Jeff King <peff@peff.net> writes:

> However, it turned out to be a one-line patch.

Thanks.
