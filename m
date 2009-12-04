From: Junio C Hamano <gitster@pobox.com>
Subject: Requesting for pull-requests for 1.6.6
Date: Thu, 03 Dec 2009 16:27:55 -0800
Message-ID: <7vljhj1t2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: spearce@spearce.org, Eric Wong <normalperson@yhbt.net>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 01:28:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGM1v-0006lr-OI
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 01:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287AbZLDA2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 19:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbZLDA2C
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 19:28:02 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbZLDA2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 19:28:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6618D85DBE;
	Thu,  3 Dec 2009 19:28:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=oDa2
	hLqWlxAk5Eym66yPcMFFFjE=; b=Jnb7wwAKYFnyhm0dP9Q1J3/lcvgTR/rmZaYh
	t6JszbMDwzd32vUW7rOkWMvxkmuGl3TfXEJguwfbUdB3Tkao8ZF+otnKV7RCmtYT
	F8QiRcxNNQ94EvrVa3tI9ERx18wiq+PTic2imDuJNTSELI5Pn7WAMNqZUg+Ua7g4
	CZ55LUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	ugM6FXC6zJ2dcCTHXIlwkSd5S0kJWURB1d1c+UF46wcJmkYAooj4fN0heKoZk8oX
	DJGqzqnK8weCTqsmXTgctuhq4wSUkClwe8GznNsmFXVKlSBJnNJIE6a6aYlY5GyM
	lMvgK3j1rd+D9Ia7vg4bZ61QuyCWyquyB9PAqWtX3eE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FB9A85DBD;
	Thu,  3 Dec 2009 19:28:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BC3885DBC; Thu,  3 Dec
 2009 19:27:57 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1BB7BE2-E06B-11DE-A8C5-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134485>

Sorry, I should have sent this out before tagging -rc1, but if you have
fixes and well tested new features that should be in 1.6.6 in your
respective areas, please give me a pull order soonish.

Thanks.
