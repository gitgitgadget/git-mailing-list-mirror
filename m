From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: fix grammar in gitattributes.txt
Date: Fri, 18 Mar 2011 09:59:12 -0700
Message-ID: <7v39mkxt3z.fsf@alter.siamese.dyndns.org>
References: <1300454067-9934-1-git-send-email-alcosholik@gmail.com>
 <4D836EE5.7060003@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 17:59:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0d1L-0002op-Nr
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 17:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab1CRQ7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 12:59:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757193Ab1CRQ7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 12:59:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 109D441CF;
	Fri, 18 Mar 2011 13:00:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y09wIuSzRHlCTv8HOr5pVUiHZaI=; b=VzFY2s
	vcrMRmqZjFzg2tMZobMu9sHdZXfuMWEnWWIgti02yPcj2yrTjBMCp5YJ8V4NcZ9+
	NGOpDydObxWEfPAkCEMoavfzFvWMVDsYvDBZVopnRqdf3rQijmVqaoJW/rt9AW3D
	PWFpm73PnFTlROYXy3hC8j7DHfhrPgaJwemu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=usBa5EoMXBbG/u2iZtcvGT0X+3EdiGSq
	c+/9yyfkSBVrwnHsUtb9cP3upRcj5vFQLorvztasmkEjaliWsrS5sQmcF5RrQjQe
	PjzZp4t7GDQOc/uYKjmiP31/JhVhZRckiYZ6bOtLb4A6CTeZmdwEqN4sqJ7Yttxi
	ZMmPsQTR11c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D29CA41CD;
	Fri, 18 Mar 2011 13:00:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C2A8941C9; Fri, 18 Mar 2011
 13:00:48 -0400 (EDT)
In-Reply-To: <4D836EE5.7060003@xiplink.com> (Marc Branchaud's message of
 "Fri, 18 Mar 2011 10:40:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 485C0C4A-5181-11E0-A192-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169339>

Thanks both; applied.
