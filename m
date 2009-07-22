From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.mak.in: continue fixing NEEDS_LIBGEN
 autoconfigure feature
Date: Wed, 22 Jul 2009 15:35:39 -0700
Message-ID: <7vprbsbb2c.fsf@alter.siamese.dyndns.org>
References: <N0R1rELOlDFDG8pOY2LYJHmWygM5WFD8q_fNZgfE1A2QOX1yg6OPCZW4RbX5i03hokq4Bx2zOjM@cipher.nrlssc.navy.mil> <57XXtFYcpNU4ayC2onbxyZE72nxUH64HrjFA1KTX3lvwrSUaKMsqemp5CX0U7W460zAC_hc0GdA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j6t@kdbg.org, peff@peff.net, david@syzdek.net,
	jnareb@gmail.com, bonzini@gnu.org, nicolas.s.dev@gmx.fr,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:36:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTkPt-0007pc-NB
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbZGVWfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755155AbZGVWfz
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:35:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbZGVWfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:35:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A62A4102FD;
	Wed, 22 Jul 2009 18:35:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4CE40102F1; Wed,
 22 Jul 2009 18:35:41 -0400 (EDT)
In-Reply-To: <57XXtFYcpNU4ayC2onbxyZE72nxUH64HrjFA1KTX3lvwrSUaKMsqemp5CX0U7W460zAC_hc0GdA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed\, 22 Jul 2009 17\:15\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 04804812-7710-11DE-9570-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123810>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> You probably want to apply or squash this somewhere.

Thanks.
