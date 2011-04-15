From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (Small) projects for students
Date: Fri, 15 Apr 2011 11:45:46 -0700
Message-ID: <7vk4evcq05.fsf@alter.siamese.dyndns.org>
References: <vpqmxjra0am.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 15 20:46:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAo1p-00020O-Dj
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 20:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab1DOSp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 14:45:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab1DOSp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 14:45:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC1343A99;
	Fri, 15 Apr 2011 14:47:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jW/QQ3trr6Ggg6BzN4IgxZH5S8k=; b=CU37bU
	to8aTTaFNqVoTcDtSwWRiVlM8f9kj/oF45IZfZ8OA6R4MFnkwVlN4Ds6pymOKTtP
	XnjJAztjIU2YhLFo4zlvgqvvX/2k2Mir8I4YEW2sfjwCgoRqyy+b1p8SLleGG5SI
	u5DjNQFTeDEuX35RgQEvSl6ZABUNqM/B7nvZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=py9ZEDvKP7Yv98/Aqrhs4zALJNwDK11P
	xdII34ZVEG6WVpA+g7UHjYbxNLH/lxVGIL7QN6xvpoOtiH1MJmOKgXLj47NbsdHt
	qdikewFsBiWlpKit+CqpI2h8nmgpzn2AXBPYJuy1WXY4wHZpvKJUYPYN57YFGlDC
	8FOF3fKV1Z8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86E033A96;
	Fri, 15 Apr 2011 14:47:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AEBF03A94; Fri, 15 Apr 2011
 14:47:46 -0400 (EDT)
In-Reply-To: <vpqmxjra0am.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 15 Apr 2011 19:31:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC935358-6790-11E0-B921-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171629>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> To prepare this year's project, I created a wiki page listing ideas of
> projects they could implement:
>
>   https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
>
> Your comments, and idea suggestions, are welcome.

Thanks.  I agree it is a good idea to list bite-sized projects to help new
people to dip their toes.

The last one seems to already have a weatherbaloon, though:

  http://thread.gmane.org/gmane.comp.version-control.git/111799/focus=112003
