From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Update 'git remote update' usage string to match man
 page.
Date: Sun, 15 Nov 2009 13:04:06 -0800
Message-ID: <7vlji7fqk9.fsf@alter.siamese.dyndns.org>
References: <32c343770911151146m82ac4a3p12ecc988da88ab6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: finnag@pvv.org, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 22:04:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9mGp-0003uR-68
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 22:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbZKOVEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 16:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbZKOVEP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 16:04:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbZKOVEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 16:04:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E189780243;
	Sun, 15 Nov 2009 16:04:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=YIkqZGN8lm7/iI79RKm8Z4b
	ClRPPceXQe//tJlwfDWvzPlm5yBBRMCr6HpcZwV2n58POl6ieeu+UTx8ELeo+VTk
	hulhCTlkwMSXhKWW4dEqmAXWQFANc1G3Iw+jrS7/H+CtM+O/ZGT8D02FLBfGu3ig
	o+K/qxlKy7REyoNL2HCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=R3lp2Sf9h9hi6ISkYPKsWNiEuqhpAQnxiGk1auE68+FkjMJqb
	Jccp8/NEKDisdQ3NhnhrTZeftoIr3bGsHzYP6R9VEwlwMJbbVHSqeioqJNIbThQg
	77Jup0nnOZoflDo3Dy7LxztncELWh8/gR7aXMmKCwfGrTxUsWfCZV87kNA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A746D80242;
	Sun, 15 Nov 2009 16:04:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D440D8023D; Sun, 15 Nov
 2009 16:04:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D933EB6-D22A-11DE-AFD6-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132963>

Thanks, will queue.
