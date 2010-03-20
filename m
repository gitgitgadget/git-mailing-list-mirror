From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: Entries for Alex =?utf-8?Q?Benn=C3=A9e=2C?=
 Deskin Miller, Vitaly "_Vi" Shukela
Date: Sat, 20 Mar 2010 08:15:40 -0700
Message-ID: <7vr5nfowgz.fsf@alter.siamese.dyndns.org>
References: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Mar 20 16:15:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt0P2-000516-Dp
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 16:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab0CTPPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 11:15:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab0CTPPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 11:15:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E31FA2AF4;
	Sat, 20 Mar 2010 11:15:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fv3GBwdGPcVHNYayMX9F6xS8Sy0=; b=O0qdiE
	Q7O2Uzxk+QJG98z7DuoXhmUQZ+tfH5x9ld2TJ+ps9nR4+/5wMIoOVBRQ3d4h3bUm
	3loguyzEWvhWWvgih84KZFEeyjFWn9u0kE+9Gw2S8rx7k1OsidGtrUlmd9FcekqQ
	hmYHlo4jUdrMnD+zG+a4fCd2chLgO873bGHoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EZuVofukAEYjYtfqUarSkdfzp03R+XIs
	Md4PzfgXMAmMVCawffVr7P0/etl7q5ZPe5oEA5tjJRco7ZfCLQkUJhICC4h7F4Qv
	JC8+4Cvl1ZFe6/JLfl16cVPMVV/fTvF52ToapJCpoeJWwDy0vWNofhrOZblo7fSi
	QEcZOZHRGlA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53109A2AEF;
	Sat, 20 Mar 2010 11:15:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD628A2AE9; Sat, 20 Mar
 2010 11:15:41 -0400 (EDT)
In-Reply-To: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 19 Mar 2010 12\:02\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74459C16-3433-11DF-873A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142715>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> With the current .mailmap, git shortlog shows the following for these:

Thanks for doing the gruntwork; very much appreciated.

I'll backburner this and wait until the people who are described by these
entries say they want these entries in the .mailmap file.  If they do not
like the variant that your patch suggested, and if they care, then we will
get updates that should be applied.  Otherwise they themselves don't care,
so why should we ;-)?
