From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Document signature showing options
Date: Thu, 20 Sep 2012 13:40:05 -0700
Message-ID: <7vvcf8a0nu.fsf@alter.siamese.dyndns.org>
References: <1348128638-26003-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 22:40:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEnXp-0007Al-RF
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 22:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab2ITUkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 16:40:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084Ab2ITUkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 16:40:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A4759CC9;
	Thu, 20 Sep 2012 16:40:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=w1fMwx
	PCqMjgaK/90SgdtqVZJ01z85+kL0m5wTMjvNKur0s+UyHRUSh65+2xSD+hBOItK7
	7tQPLD8uYBktgnfs1tNWCRvrnbJVJEGxb+h989MDrNvB0sTxolt6m7vsFZATQjQo
	mvbQZ+62jjsaa6AeC9bsNSXt2iRu+QgCSY+zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cpw7ekiyuQ3ILGc1wglxVUBSuW610kYH
	AK62V6lJHh8ksBzgFSfWNExfDcNBxy9VBWx8Bu4J52PYmABRXw9KyiEnDFCTgtuS
	0gxX6vgBuyf4Ikmu6ooiP09/fKYMRSix7WjAYrUQs7R5+DNMhTvdwYhON8TS79P7
	5KIGjWY9Hho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5812E9CC8;
	Thu, 20 Sep 2012 16:40:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D82CF9CC6; Thu, 20 Sep 2012
 16:40:06 -0400 (EDT)
In-Reply-To: <1348128638-26003-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Thu, 20 Sep 2012 01:10:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CD98FA4-0363-11E2-960E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206088>

Thanks.
