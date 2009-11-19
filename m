From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2009, #04; Tue, 17)
Date: Thu, 19 Nov 2009 10:11:09 -0800
Message-ID: <7veinubd1e.fsf@alter.siamese.dyndns.org>
References: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
 <4B03B315.2080407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 19 19:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBBTY-0001xR-Py
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 19:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbZKSSLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 13:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbZKSSLN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 13:11:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbZKSSLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 13:11:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4F219F74A;
	Thu, 19 Nov 2009 13:11:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5q9HY87rrrXOkjEdm6xIGUEJCjU=; b=AlQI/dEWClbADWLIGiIlUj5
	8qrHxXpLZx4fRAm/iSZKbv1Oeepc6kSxKXs1Dg0edCLFH9BT5OlZwQSnJtIR7uSp
	5LP6KRP//8qyEz3OebbuT0hvnY+Szb6jCO/ZN+/spzh4jq65dF+Pcp8fgP/D+ZLL
	pzUNE/s6wE/wDuu9GbM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nl4gf2gjV1k0xgAxlyzkxeOFgwkqxUr4X6xEbD97aPzyWDN7A
	xQL2GVp7iSyphnug6MIIdUsuVh42UG+dWYRtLoe9oxSyfgshiLnl8Lw0YImkG7rW
	6wfYSlkObJv7+UpVjZQ9aC85FBmisZHCgNt2D/ivNpLFc7xtT1xbuEKwbE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C259A9F743;
	Thu, 19 Nov 2009 13:11:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8CD599F73A; Thu, 19 Nov 2009
 13:11:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ECEBC6F6-D536-11DE-AC4B-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133240>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Ramsay suggested to drop the one at the tip, and I agree. The other two
> patches are good.

Thanks; will drop one and queue the rest to 'next'.
