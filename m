From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Document ls-files -t as semi-obsolete.
Date: Tue, 27 Jul 2010 10:36:26 -0700
Message-ID: <7vsk347rol.fsf@alter.siamese.dyndns.org>
References: <1280162391-18701-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 19:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odo50-0007dO-HG
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 19:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab0G0Rgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 13:36:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab0G0Rgc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 13:36:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8143DC8A46;
	Tue, 27 Jul 2010 13:36:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=I2MdZQahKepWL5fPxF5BNUfuc0c=; b=xxEL7LVvptF6PF5CzDbL6Cg
	g2Qkfh5LU+cVPK729V5M5ecbDD20YKK7axC7dRSPVpK0Y6TUMb+/gGU/L5r02T8k
	Z+PT3f3Ge/U9XM8Ngvie9vyPFBXhEhoqlyhRLTxhON6CjMJhiEt4UNQhTcp+c2sg
	M7IYLicA7lKJ4i0xbfWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TPAJnX2bQG6aIjZ5ccAXoJZWzEHCJpwjVleVSjVOV7wHneYNL
	UGx1q6xB7BC/a9GSEzOUL0cedm1I1yMBGK54tScdOEtveLJUE71V0AzZ93sboZ7A
	Hfmi1H3HFOKmzV+QL9Welni9jO+YpEDlmi4Jn6UGyvc4e6yIQeSxFbcH5o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D4DEC8A45;
	Tue, 27 Jul 2010 13:36:30 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3FC9C8A43; Tue, 27 Jul
 2010 13:36:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7DCB32F0-99A5-11DF-A280-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151963>

Sounds good; comments from others?
