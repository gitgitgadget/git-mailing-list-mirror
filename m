From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull gitk update
Date: Sat, 24 Mar 2012 01:32:17 -0700
Message-ID: <7viphus8ku.fsf@alter.siamese.dyndns.org>
References: <20120324055540.GA20898@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 24 09:32:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBMOp-0008Ud-AY
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 09:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab2CXIcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 04:32:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754855Ab2CXIcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 04:32:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 192DF33A9;
	Sat, 24 Mar 2012 04:32:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8xnFxT+Nag4ZCnns452+IpA03g4=; b=uNo655
	MvfoVYkTMGJMJkXtkXCIOHCQ4KLwGHPBCVZAndpeb2vrVLCr/dzTHNyGYt/dsIgW
	s3JPUKin6gGglxeC2Kzjs88ufkNm3qR8HuqRed+uN+IugVIrwcGuwLfYAv0VeOLx
	giJNpRcBvTzduZpXimg1zjI+ZVnhywfpUn91c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tFISLunq37jyaV5a8HE0IaVYLGFKEewX
	FBeznoO3ZtVjKIknxxhKvNP2SP1Nq8BcrcPveOFIIXjpXBy+UxovlQhPeeFFm9Vk
	x+iAJfWdlKJ7X7TI4IqLPqQZ5u+fUQ+RbPvOAG0E6qbIfTgOfzBpQ0WauXfPtixf
	QsVruUfokjk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115F133A8;
	Sat, 24 Mar 2012 04:32:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F6BC33A7; Sat, 24 Mar 2012
 04:32:19 -0400 (EDT)
In-Reply-To: <20120324055540.GA20898@bloggs.ozlabs.ibm.com> (Paul Mackerras's
 message of "Sat, 24 Mar 2012 16:55:40 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEB80AA2-758B-11E1-9351-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193821>

Thanks, pulled.
