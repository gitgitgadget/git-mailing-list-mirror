From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] request pull for git-gui
Date: Fri, 05 Nov 2010 10:41:19 -0700
Message-ID: <7vhbfvsm68.fsf@alter.siamese.dyndns.org>
References: <87bp66nrnk.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Nov 05 18:41:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEQIG-0007hV-HH
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 18:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0KERlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 13:41:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab0KERle (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 13:41:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B8F623B9;
	Fri,  5 Nov 2010 13:41:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=97OI6BFO/5pcOjjKTCZ9qWI9mE4=; b=GRdvJX
	tWLLoF+7ovICLTTXKwzVEUtlQ7tR/4bwcS+vrNy9E5uC943MTbk20iadZ2n/Omop
	mHs5DPOt82GBsfJgskwq21kugVOOwmDchLdFmiogTJjOMaVv2MJvwBp4YTZlJYK2
	IAVOtklrfpTxSs6/ioDaEg9Qt74BI4Ms3EtDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QWT0b6Y9gwia+RYGrwdv1hjVF8DtUHgp
	iQapdjic9LfIArvG0ILoKLInvb5Yebrvdchc4yRtcQTaRDBujnTv1IKODBKwx7/g
	DZlWvlV+mF7gN2ZV43ILIKY1UB+KZeSeUteyVbUElCsXIK/09zDrlYQBdvZ0s3sO
	wKn1D30FWa8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B48323B8;
	Fri,  5 Nov 2010 13:41:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E49BA23B7; Fri,  5 Nov 2010
 13:41:23 -0400 (EDT)
In-Reply-To: <87bp66nrnk.fsf@fox.patthoyts.tk> (Pat Thoyts's message of
 "Wed\, 03 Nov 2010 19\:17\:19 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EAED944C-E903-11DF-91EB-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160821>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Junio, please pull the master branch from the git-gui repository. This
> contains some fixes for Windows and the color parsing that was discussed
> on list recently.
>
> The following changes since commit 00e9de72c8f9b7c048bb56a59be9567d69dc1e01:
>
>   git-gui 0.13 (2010-09-14 22:42:37 +0100)

Thanks; will do.
