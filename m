From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.0.rc1
Date: Sun, 31 Jan 2010 11:23:22 -0800
Message-ID: <7viqaidqol.fsf@alter.siamese.dyndns.org>
References: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
 <20100131073208.GA15268@coredump.intra.peff.net>
 <7v8wbeg0qp.fsf@alter.siamese.dyndns.org>
 <20100131091446.GA25704@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 20:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbfOS-0001qP-Hk
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 20:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab0AaTXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 14:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915Ab0AaTXb
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 14:23:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab0AaTXa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 14:23:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE44953B0;
	Sun, 31 Jan 2010 14:23:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=nV8c2U
	IWuDD5AR8waNpWrVQBix+xkRHG7tpVS8EyMJJy9SkHVOfevG00nEpQd3FDRv/w0c
	L3bDDtVSMn+SqL9GROMLsRhPJRqlseuFf8+UtMrmF5eG7lcu4uZlOEI8ugwj7/A7
	2RG5ZUPKzpgyK9/fBd7KUQp7J21YsbRLyuJDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Owc9YNSV5xZ9laRu501wutHmbCHu8TDh
	zQvFi52k1kw/pOZ/qcuCebyWOroAK+DoVqSBPx86cA0kO+TufX7wXKq92wnlHaq0
	PAwCN6As2V1ezVR9Mzyr5FlVpoQDWA02xE1LTxjSX7nrTFCzfHdG7RLLxs1/AHh4
	IGiIDQTzcBE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4EFA953AC;
	Sun, 31 Jan 2010 14:23:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 121ED953AB; Sun, 31 Jan
 2010 14:23:23 -0500 (EST)
In-Reply-To: <20100131091446.GA25704@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 31 Jan 2010 04\:14\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BC1B864-0E9E-11DF-ACAB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138553>

Thanks.
