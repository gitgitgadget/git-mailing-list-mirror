From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RelNotes: Spelling & grammar fixes.
Date: Mon, 18 Nov 2013 14:12:03 -0800
Message-ID: <xmqqpppx9x70.fsf@gitster.dls.corp.google.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
	<1384448473-25840-1-git-send-email-marcnarc@xiplink.com>
	<xmqqmwl1blg7.fsf@gitster.dls.corp.google.com>
	<528A7016.7020307@xiplink.com> <20131118200010.GJ27781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 23:12:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViX3G-0006wK-Um
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 23:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab3KRWMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 17:12:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab3KRWMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 17:12:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35CA351A63;
	Mon, 18 Nov 2013 17:12:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WNG3P50WvmqWWuLKY9J0i/GD9J4=; b=eRGzj2
	M9UyrJS61ttlysq6JH6UXKbr/Y8V0EuC+nb6oXfjHETJ0PvHfMsrrVPTMsIL57c+
	fW/2mIVIHS6ErkptCMEOakQ2kz4enr6LxfjpCL9biM5amD8go1dn2Qu90/1MrN0A
	nNBLAhJLpy/fRoLaJrhQRjen15VghqFmvVb1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ifj8gfwgc0ZXbQmm8MlRHDrFY8UubH7X
	EbwJ3b57kk28QtQeN5fuS8SkrvwUdGqA300e75s30C+IXt+6Ka2NyrUgE/UtYQdj
	ljOdV4jTjJJUxgdMYXQXJyD6y2FzfE+8zdBQc7wQIuUIswUJHEa4jhPd++J06JTy
	7eO1HCQKFG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F76F51A62;
	Mon, 18 Nov 2013 17:12:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 634F951A60;
	Mon, 18 Nov 2013 17:12:06 -0500 (EST)
In-Reply-To: <20131118200010.GJ27781@google.com> (Jonathan Nieder's message of
	"Mon, 18 Nov 2013 12:00:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 75E37F9E-509E-11E3-875E-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238018>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Marc Branchaud wrote:
>
>>  * "git branch -v -v" (and "git status") did not distinguish among a
>>    branch that is not based on any upstream branch, a branch that is in
>>    sync with its upstream branch, and a branch that is configured with an
>>    upstream branch that no longer exists.
>
> Ooh, this is much nicer than the wording I suggested.
>
> Thank you.

Yup, I'll take this one.  Thanks.
