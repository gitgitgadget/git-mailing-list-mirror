From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] send-email: Cleanup { style
Date: Sat, 10 Apr 2010 13:02:00 -0700
Message-ID: <7v633zvzyf.fsf@alter.siamese.dyndns.org>
References: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
 <1270911236-32476-2-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 22:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0gsh-0000fE-G3
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 22:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab0DJUCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 16:02:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab0DJUCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 16:02:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F6C5A93DC;
	Sat, 10 Apr 2010 16:02:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S7wpkqlfgWYHiyLy3cIw9FCR0Hk=; b=cV2+jn
	Gc+X589A2FahybipLaETF951GipXZqrnDQUIqoupeJZ5uYRXW3wbGqEvvqTQPaZ0
	Fxg50t3xI46BIVb3xk8z7d9tcdzicytREpySUdNTfhckTzfTpQc8S2TiHfG6vGMn
	d3wWtm/Ki5lWnLSNp0PzYSkjuPS/q++Z7Pj+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WT1SNPzyBRkm4Ko0Ga73pbvg/v1dW0g8
	nhBhGX0xuJQ6BJ/BoDXpHSmYFJkHxVHGQ3tRLin9u53GBwBwg9uDapFfn3I3yct8
	pWCpxRs1vhiBReBy0yqNeiISEmAVq46IkBASP29xNMtUiTxDgyOgOe0k+3pEJEcw
	h59TIp+K/Lk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1417A93DB;
	Sat, 10 Apr 2010 16:02:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C205A93DA; Sat, 10 Apr
 2010 16:02:02 -0400 (EDT)
In-Reply-To: <1270911236-32476-2-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Sat\, 10 Apr 2010 10\:53\:53 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F001F814-44DB-11DF-B897-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144589>

Thanks; will queue all four of them.
