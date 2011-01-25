From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Mon, 24 Jan 2011 16:24:33 -0800
Message-ID: <7vr5c1ltj2.fsf@alter.siamese.dyndns.org>
References: <cover.1295295897.git.raa.lkml@gmail.com>
 <1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
 <20110117210828.GC27029@blimp.localdomain>
 <AANLkTinZCegWW-6uQ++uO9fGQ4SQ34=W4TJXW6ii5jXD@mail.gmail.com>
 <87wrltnakc.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Jan 25 01:25:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhWir-0004Qq-K9
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 01:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab1AYAZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 19:25:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab1AYAZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 19:25:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1773B34E9;
	Mon, 24 Jan 2011 19:25:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bt6WFITPyZEKe/D1a6KMIY+8TEw=; b=n7p6CU
	iT3Gw5qceTWl0wE8Ae+T2GBFW8+9yviIvLIP6u3kqIFKflsDxxdElanAqFonikdV
	Fvu4GkTT1p0029IzP6wf0tJg+fmOyBWTGbFbK4itQp8MiR83MdJm24Yc1zDh0Eef
	AbeM+VNEXpkwFz2rA6ZmgnunDdSgwCRjoVcqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XpP4ueuAdM4U7Erpl3EgOyp8kGfE7KU1
	PcpCviNDBvn5OIX2rYMZgrIi59YlMCmYdX18OMLIbUVVzgUo5KfveQUIpYl3gFAM
	yX+9YfAaJ6Hd+yARArC4GVwb5AFYCbaoFg6tCnYeF8nWe0mZM5DRxFqrO2wi6tXg
	dtXReRkRDEM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7349634E8;
	Mon, 24 Jan 2011 19:25:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1268C34E7; Mon, 24 Jan 2011
 19:25:24 -0500 (EST)
In-Reply-To: <87wrltnakc.fsf@fox.patthoyts.tk> (Pat Thoyts's message of
 "Mon\, 24 Jan 2011 23\:31\:15 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A12A62A4-2819-11E0-95FF-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165464>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

>>Is git gui development stalled? Should I perhaps send the
>>i18n pull request directly to Junio?
>
> If you post here they'll get picked up eventually.
> If you want to use the mob branch, we can use that too but you would
> need to post here and to me to notify everyone.

Oops, I probably should have pinged you (and Paulus for gitk, Eric for
git-svn) before tagging rc3 today.

If there are last-minute changes that must go to 1.7.4 final, please let
me know.
