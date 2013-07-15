From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailmap: Testing the single letter name case.
Date: Mon, 15 Jul 2013 08:54:55 -0700
Message-ID: <7vzjtnbyy8.fsf@alter.siamese.dyndns.org>
References: <1373665135-32484-2-git-send-email-gitster@pobox.com>
	<1373700020-30436-1-git-send-email-stefanbeller@googlemail.com>
	<7v8v1aicn5.fsf@alter.siamese.dyndns.org>
	<51E198FC.5080005@googlemail.com>
	<7vk3kugqkl.fsf@alter.siamese.dyndns.org>
	<CAPig+cR8zhcZ9_Gjq9mv0kPMe7F=szeSANG1b3J3gitoWCZaxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyl78-0006Fn-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920Ab3GOPy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:54:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932668Ab3GOPy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:54:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41F02311B9;
	Mon, 15 Jul 2013 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=pyJW+g
	nPuiT+hxuXFXg6wRktmNm4Z94kcVQ6oW5qvugOo0Yf0vnCla4rY0IuC7xYfba8n/
	YRJ4d6TwiHPBZbdUUmTN6+JZe2KHF0A15tjtGjUZGd+0o87QG3XN5X2zwvCgAMM2
	RvUKDKcHKfPrJjTtHBBFqCFJVT9grgsaFTVzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QaY2EnyCcXiBz4YeWP1ODVR8rJi00jp8
	Jb6AucUFet+vmF+onR8exA3QehtVciTqrSIjQgk698fZbHUF7OziHOMg+9H998LY
	rDTnMFgM5jqYiod7VVBGzkJp7leFwC2CzG16DjJ2GxzcdB0rHLtiKaQHCKMT7fH1
	IJMa+41V1Hc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EBF2311B8;
	Mon, 15 Jul 2013 15:54:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8226E311B7;
	Mon, 15 Jul 2013 15:54:56 +0000 (UTC)
In-Reply-To: <CAPig+cR8zhcZ9_Gjq9mv0kPMe7F=szeSANG1b3J3gitoWCZaxA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 14 Jul 2013 22:31:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5629008-ED66-11E2-9296-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230485>

Thanks.
