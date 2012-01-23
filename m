From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typo in 1.7.9 release notes
Date: Mon, 23 Jan 2012 10:11:21 -0800
Message-ID: <7v62g29tme.fsf@alter.siamese.dyndns.org>
References: <1327320598-28683-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jan 23 19:11:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpOMa-0007zv-Fy
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 19:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab2AWSLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 13:11:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab2AWSLX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 13:11:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F3816ABC;
	Mon, 23 Jan 2012 13:11:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=gNVCVj
	fOKeEx9dpNqwVyL1FN5Lye3/YR4jbWsJIAAOK6EuAQcj81NtMRQIZyiNz483/CYB
	A0O7MUpJBcdtKXNOT6X1tXtfsuSy5kW/jB4LupdCL7mk8kD8272VXxgp+uh9qbwH
	kwlih5NPY35SUa46KutBaBg6JRyZp0Zi/IIhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pLwugC0zyCZ6GPlf8TXx46nAYc0nVM7u
	bblXxGOyuiwnv1m/AZpAzmNm5jhwOfE6VuhH0nIcHVOYzVLkK8io8B9foFgbij+H
	2ZbJ6eW/n4nadydrPuVECyz6FoHq19AlmVCM92TNeh2rH0aH5ERYZVdV2wHt4flk
	NsCOfpgVzgA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46C9A6ABA;
	Mon, 23 Jan 2012 13:11:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D25E06AB9; Mon, 23 Jan 2012
 13:11:22 -0500 (EST)
In-Reply-To: <1327320598-28683-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Mon, 23 Jan 2012 13:09:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A82A2F2E-45ED-11E1-A9ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189004>

Thanks.
