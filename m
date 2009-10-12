From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] user-manual: use 'fast-forward'
Date: Sun, 11 Oct 2009 22:05:24 -0700
Message-ID: <7veip9jj6z.fsf@alter.siamese.dyndns.org>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
 <1255293973-17444-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:07:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxD8L-0002gf-Ty
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbZJLFGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbZJLFGO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:06:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbZJLFGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:06:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AAD3E55882;
	Mon, 12 Oct 2009 01:05:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dubYu4iebX5bN/j0EwOVSWVMmEg=; b=n54SIhk9lga6rpt3JtGlxXX
	FnlzF9p9/ldL11gccceS1p2ZrQpWeTDwxhjNuzNfkjHzemBoPb7so3nFYVs5B7YI
	Fq4u+hhX2He1kk8oUf4C5GsbT8kfUtkUFMm361HivtCtS/ShEnaoxXW+wVo9KO7o
	+1fJkwXJTkvowkJQV76c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mILWIzQX298qpczqMXGjL5im1efACFD9uHnVXgtlfTTWLGJ9S
	o24H56xSr1fKUamudxKBG73Bcaxq7cUsm8KEL/6jPms6ZYEmSEKzQRP3USBl07gY
	Onul/fASwW+/nIEapFXMIa5ASS3I1LKbpgi6d/XFOZs0nnKLDmBM00pWNg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B94655881;
	Mon, 12 Oct 2009 01:05:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C0F95587D; Mon, 12 Oct
 2009 01:05:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DBE46FCE-B6EC-11DE-B47D-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129974>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's a compound word.

Thanks.

This removes 7 out of 37 "fast forward" in Documentation/ directory.  Are
we going to convert the remaining ones, too?
