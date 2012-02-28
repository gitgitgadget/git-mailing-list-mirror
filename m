From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: use {asterisk} in rev-list-options.txt
 when needed
Date: Tue, 28 Feb 2012 11:38:32 -0800
Message-ID: <7v1upezr2f.fsf@alter.siamese.dyndns.org>
References: <1330443348-5742-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:38:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Ssp-0005B2-Sx
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab2B1Tij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:38:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757280Ab2B1Tii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:38:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11C0B6705;
	Tue, 28 Feb 2012 14:38:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Ece//L
	Ma/IvIYUz5cTLkaaf5ar7eGvHf6bjXq9JrGxXAVQEzLNR4XmfgOiIdc8OwszLx7V
	IQuckl2gN/KStZR9oZjYR5amgXPm6+Mrh7yeL3IxgUvGmgvv0Jn7w4KoddEYUICd
	c0c5czwzOpujX6qkTNeR3RijZzNlfr8MQMWi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ju+y50wBwCNra3Uxzr7rf4QuAjYwyLcZ
	rzrr7Ka14+gB0iG723bw3y7qVbBWfc+UkCz2mxHyBUTapxnP3pONNMm17/fy2VeA
	TLhFf0BMBqT7gl7JVSLp1cgQRJ/7dlWhWUekkHDfSN7tZvS71Nv0hyZU413/a+yF
	T3MvoWtWmgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A0276704;
	Tue, 28 Feb 2012 14:38:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96FDD6702; Tue, 28 Feb 2012
 14:38:36 -0500 (EST)
In-Reply-To: <1330443348-5742-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 28 Feb 2012 16:35:48
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE98FA60-6243-11E1-AE7C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191775>

Thanks.
