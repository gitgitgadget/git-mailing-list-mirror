From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch 04/15] diff-export.patch
Date: Tue, 16 Mar 2010 00:24:58 -0700
Message-ID: <7v7hpcn2yd.fsf@alter.siamese.dyndns.org>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054316.503338000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrR9M-0003yP-G2
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937515Ab0CPHZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:25:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936263Ab0CPHZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:25:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CE73A201D;
	Tue, 16 Mar 2010 03:25:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5n1NcCs/S9nLA0dIUy2ZOPG3STc=; b=yE6rMMX21dKYJprVkUYTWE9
	vmnn7UQ3oj7EEa5+YZ/VYndGk3kAJgkXFENCpi/wcJUas4BdmfwDtk/JEaPt7rl4
	D1Qq0Alk1Jp7HLgvPNheVzVq2wW0lbdapQc+nXuSC1PhNQEpvoJ4bHapZX0Vo6vX
	pfYSOuORBEtgF0hxoMnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KUv4pmumFkFKVybhDl7dazMZbrb/vZPHF6GeuwLvH/O4Azq18
	7sd1C/Rdf1vP+muc1uGKUXi0OFCsnt+Dj6qc2/yS5zdJqyyuQ18e15rcaFBvfJtL
	QTHYjiBo/RKpTKkyZV6d43V6U1x9HbW7goV6Y/nAxCUTtlsMS/ZZRUz5xw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ADC3A201C;
	Tue, 16 Mar 2010 03:25:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F867A201B; Tue, 16 Mar
 2010 03:24:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0903BDD4-30CD-11DF-B8CB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142330>

Looked sane (I didn't apply nor test, only read it through, though).
Thanks.
