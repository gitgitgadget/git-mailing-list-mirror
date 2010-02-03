From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk translation updates needed?
Date: Wed, 03 Feb 2010 14:24:09 -0800
Message-ID: <7vfx5iarg6.fsf@alter.siamese.dyndns.org>
References: <20100201151647.GB8916@spearce.org>
 <201002031113.11212.barra_cuda@katamail.com>
 <7vsk9ihzlp.fsf@alter.siamese.dyndns.org>
 <201002032156.16101.barra_cuda@katamail.com>
 <7v636ec677.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	Paul Mackerras <paulus@samba.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 23:24:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncne4-0006z4-Js
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 23:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472Ab0BCWYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 17:24:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab0BCWYT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 17:24:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BA3196D2C;
	Wed,  3 Feb 2010 17:24:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WhjVrUHiwHcHAGtNxrkvPs81bKE=; b=df/aLa
	fZ2Tn1WE7uOrC2YvGgTpbGTHSI3btEkSjMs27KNdqRFxMHRF5IziTn5TWT7jxVGw
	Zmzo53SSQncZL6tV7Wus5jQUKjJcX9C3B8n2ydN+q9tKybk4M65ggQ6O8TGXTxNb
	wUA4QcuCDRfneyFQg5LyS0YA4S2A4uPgjlBIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V/Ge/gdA/n20IAX8HWrkCR2yNyAF6C5X
	qcwSXjrE0Wm4c8F5SPvYv98dZUrIHYV+5BzmdoC0UqoxSGksyiVh7EcNGQ7da5BN
	XqQJdILTALNRM5XzYcPxduN4LvfimyAerRRJb0KdEJjfHw0ppWpZpJSMVtHCtlz5
	mx7Wm2OC6rw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C115396D2B;
	Wed,  3 Feb 2010 17:24:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0D0C96D22; Wed,  3 Feb
 2010 17:24:10 -0500 (EST)
In-Reply-To: <7v636ec677.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 03 Feb 2010 14\:20\:12 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DCE62A7C-1112-11DF-BCC0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138910>

Junio C Hamano <gitster@pobox.com> writes:

> Is this a bug in "gettext", perhaps?

Scratch this; I was not reading the blame output correctly.
