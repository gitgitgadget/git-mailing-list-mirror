From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] fast-import updates
Date: Wed, 17 Feb 2010 15:29:12 -0800
Message-ID: <7v635v4f1z.fsf@alter.siamese.dyndns.org>
References: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
 <20100217232341.GA27377@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 00:29:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhtL5-00083S-QC
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 00:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab0BQX3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 18:29:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757851Ab0BQX3q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 18:29:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 002539A041;
	Wed, 17 Feb 2010 18:29:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9U+2ibEJ7GQ8A7wcUbX9/NB6hdE=; b=yjtAIj
	LMFNTBiak3uimPk8XvMsueA76Jwd1W4RlMx4QxhyimlsRqOri9udd5GxAAxvn7gR
	UeKIOla7Al57CLDfJ1bTiPNAvQ011SkeN0mhHlxdsvyWMHYy+9HJS32eMTderIgn
	TGwVnO6tHtUsvCJOWPfabi4EKppabWF1kcGHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R9unEqt7wApyHg9q0BHIXBqkQdiLG8cQ
	XEqo44y3FnSP08jL7IWd68mCgkPhB0p/tIIB/S3OygGP/FoXP329S/pRe1gnhofj
	G0+7Ufz99A4Mic0vAfMx1Q/6JTW10qXIVTixsH0L1gdvRDGx09owWojh4wC/7f7I
	6UP5UaMIv7Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C06B09A03F;
	Wed, 17 Feb 2010 18:29:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED0DE9A038; Wed, 17 Feb
 2010 18:29:27 -0500 (EST)
In-Reply-To: <20100217232341.GA27377@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 17 Feb 2010 15\:23\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50F70152-1C1C-11DF-A3DB-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140272>

Thanks, both.  Will merge to 'master' shortly.
