From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Incremental updates for da/difftool-updates
Date: Wed, 25 Jul 2012 09:36:11 -0700
Message-ID: <7vpq7jdchw.fsf@alter.siamese.dyndns.org>
References: <1343186064-49350-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 18:36:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su4ZP-0005aj-PP
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 18:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753Ab2GYQgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 12:36:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593Ab2GYQgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 12:36:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81EBD8B69;
	Wed, 25 Jul 2012 12:36:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=pI5FET
	gW3h8MjN5x8EqytPvlLK4qBVGNS4RSBia3hYCxuFB0k5iqxOOKnMwGFTdTQNhr6u
	sSxj8PhVfzk+X9YFmdZkQvXpptENTJ/PdEsk/OM6V4JU/0t+kBH792PfSkTi4HXR
	IE6tOHN4CgekBHvifphG+HPBMMTv7kw7xeHio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qewgsnBdj9UapFuE4y0IbsRE2WUo7oh9
	t4L+yxYTTPpHK05tuivoUrdi6gwBwFQ0SdGRNuOl4zoKmeRPQqYlFfYMqHifigWa
	aV4+9ofACohSxy3RdInKtLszzip2l8xZEBgjY4s+4wFYk6CwPFKUtwGwQ3FMFD/2
	sOew9JHAceM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7020A8B68;
	Wed, 25 Jul 2012 12:36:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E43B08B65; Wed, 25 Jul 2012
 12:36:12 -0400 (EDT)
In-Reply-To: <1343186064-49350-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Tue, 24 Jul 2012 20:14:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8CA0B76-D676-11E1-A37F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202174>

Thanks.
