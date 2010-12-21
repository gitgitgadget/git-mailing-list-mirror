From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: add missing configuration variables
Date: Mon, 20 Dec 2010 17:22:03 -0800
Message-ID: <7v1v5bc43o.fsf@alter.siamese.dyndns.org>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1292858305-7679-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101220212018.GA18503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 21 02:22:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUqvk-0003Uh-AQ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 02:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933367Ab0LUBWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 20:22:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864Ab0LUBWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 20:22:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15B563B71;
	Mon, 20 Dec 2010 20:22:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PixDhTwPshb+iXWNzLsI2PO95z8=; b=A5th0D
	s6YsCLc/mLatzsTKqM+sG6J516LFzw2/hynl3i6PytQcfKqC4kFYShc+lwY07HcZ
	BbayeKWp9MoDM6dxXKS5KmX1SbyFQAhBxm4NBLNQOH+L4R/8MGf+VA7qekJ0PO2A
	FEwPT9dgpEtggm0aZGf06D1hdsE/k8ObU3YBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zd5KGRGzuX7aiLCoMxFZ9quTEjgbhB7W
	xKeevvzxsU9YE9P2ZtzvYb2wRYEmG9WZtwl3qsQ1CEabTP4r8/QUu1gFc4jCLn7v
	I3axcp6xI75X/qZHjwuIcAP//EoIBXrKP8vI2KMgUXoo5VM7DDEfUT8CMFXrayFD
	HSuogCo1DmA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D815E3B6F;
	Mon, 20 Dec 2010 20:22:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C200C3B6E; Mon, 20 Dec 2010
 20:22:33 -0500 (EST)
In-Reply-To: <20101220212018.GA18503@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 20 Dec 2010 16\:20\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC079BF2-0CA0-11E0-8FFA-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164023>

Will queue with the Ack from peff; thanks, both.
