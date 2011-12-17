From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* How to generate pull-request with info of signed tag
Date: Sat, 17 Dec 2011 11:47:44 -0800
Message-ID: <7viplfdlpb.fsf@alter.siamese.dyndns.org>
References: <874nx1korf.fsf@linux.vnet.ibm.com>
 <7vbor8jw0h.fsf@alter.siamese.dyndns.org> <871us3l45o.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 20:48:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc0Er-00042V-CU
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 20:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab1LQTrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 14:47:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab1LQTrr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 14:47:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D355D7A77;
	Sat, 17 Dec 2011 14:47:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fW2t0NXifzrLvarcyBRzc9DHhLQ=; b=uXnQZo
	opoDfSp3pgXQoZD+qHAyqzliFDpMVRs+UMxM7rsFuRa2Ow/VUZkem2JvAQFgU0U0
	698qYr8505zEJU+w0IdqpsVvm0TglTxfuZxm7yjltBTMcr1+IX/ce7ZZUWJKEe+W
	6n17eFvzHOvHwNrsOemf8xoPY+pEiQiAlYix8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ICKuBJx4Fcf8LH1WE/rOSECO0Er4b9uF
	c2Wr3UE5VXV3sCcAMrSqqJZb4OKd2PbdrXknWzleW9N8P/r5cUh19QF8bFZFcgzh
	k3H240IZCRdu3seyQziQMdjtutZMGPMoU0sa2Xadg4JWsNW5yEHx8D4UIs17kUiW
	KbHtRbrAsWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBE647A76;
	Sat, 17 Dec 2011 14:47:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B6DC7A75; Sat, 17 Dec 2011
 14:47:46 -0500 (EST)
In-Reply-To: <871us3l45o.fsf@linux.vnet.ibm.com> (Aneesh Kumar K. V.'s
 message of "Sat, 17 Dec 2011 18:57:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE15553A-28E7-11E1-9618-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187403>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> -aneesh

Thanks.
