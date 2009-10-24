From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sat, 24 Oct 2009 10:51:47 -0700
Message-ID: <7vy6n065os.fsf@alter.siamese.dyndns.org>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 19:52:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1kma-0002jy-L9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 19:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbZJXRvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 13:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbZJXRvz
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 13:51:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZJXRvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 13:51:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F4C96538E;
	Sat, 24 Oct 2009 13:51:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ikj76CMbq4P7sFumAJQommun6+k=; b=YGh+U2
	Z2lFegRcazRp5IXxtugXnoXlgXDCJawqbSuHJMEdGj+Qftj/j+PuaJZoDlhFikuh
	xHckYlaRtRxVPdWpDM2/O6Os3W+0E2e4Jie7TXI+JssU7VvUzMufYhpBfdbMqr+a
	6w7BlJVPUs864qcr7z3mOOm6+AW7WmSyzmdzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vm30Jigo/Kn2Lb0+3IhEi94L15tzeYnq
	cz9aMD/llnnr7doBTizGyQJDATWdD4yJPVUvApwEOGoqs+5D1nb+uRd1CmnfXqbZ
	OgpgVBXKKf3R9yv9p42q3NZjrhpi9hWwVRTw/hGg2C0apNOtH6teDYUOP9kkyNNb
	fe9iBMynb8c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69FC06538D;
	Sat, 24 Oct 2009 13:51:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EACC65389; Sat, 24 Oct
 2009 13:51:48 -0400 (EDT)
In-Reply-To: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat\, 24 Oct 2009 12\:44\:47 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA8F416A-C0C5-11DE-B743-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131170>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Reworded the getting started section based on comments from Michael J Gruber,
> Jonathan Nieder and Junio C Hamano.

Hmm, I thought JBF also had some input...
