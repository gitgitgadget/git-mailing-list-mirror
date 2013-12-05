From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/git-credential-gnome-keyring.c: small stylistic cleanups
Date: Wed, 04 Dec 2013 16:16:00 -0800
Message-ID: <xmqqtxeoi24f.fsf@gitster.dls.corp.google.com>
References: <1386066764-49711-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu Dec 05 01:16:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoMc5-0003H8-0O
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 01:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab3LEAQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 19:16:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140Ab3LEAQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 19:16:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13CFB589C7;
	Wed,  4 Dec 2013 19:16:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=kQ1ZRP
	uj0l4lejBfY260QVnlAlA+K9wekVCo8BMCItcbfr4yA/IiakwpQcqJYYI1PwnRZX
	mQInHa4ahTzwtcP7pZDNUzcdD2ErAl+pEz3IYxQWh6mAdHdPrWFg81gg/GYZ/Oph
	UTXp8gxtqfZAjHyOq9RCoLreEp98nyyKlncQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jOYX9NF85IFhLZErLrmbEwtBCrnQPNX1
	TXsOZAXZjgHoLXfepMV2U3inggbkUuVPeosLGQF51vCNkfiFbN8LLgYWjMSPDhgX
	4ZWDbUD3ZInQ530VSyMAbszfdI8rfJ2g6WbleCXKxfOD/jR6RogXcrWWNPK6tQ98
	YqTR0yu3cSE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCAB8589C5;
	Wed,  4 Dec 2013 19:16:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC571589BD;
	Wed,  4 Dec 2013 19:16:05 -0500 (EST)
In-Reply-To: <1386066764-49711-1-git-send-email-john@szakmeister.net> (John
	Szakmeister's message of "Tue, 3 Dec 2013 05:32:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6EBB133E-5D42-11E3-B346-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238829>

Thanks, will queue.
