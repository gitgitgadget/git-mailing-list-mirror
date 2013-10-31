From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/16] branch: trivial style fix
Date: Thu, 31 Oct 2013 13:46:52 -0700
Message-ID: <xmqqbo25418j.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 21:47:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbz8t-0004Vu-3J
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 21:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982Ab3JaUqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 16:46:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab3JaUqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 16:46:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 880564D5B8;
	Thu, 31 Oct 2013 16:46:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NhE3KRNWhvNfdIYc6H2vvku0fTw=; b=jTKo0y
	sUYtTDDxAGqVcoGh0b6guCkN9n5IVv/NxfglkvwDtSdi0Ln0O9D5FruEyzKC9Fii
	cgJ9ObfOEP83o1WveorjdymiLPBG6WGgWl0Pfu2XKdGLhjn3UdFsSkadvoiIxmZJ
	twTLXriHEdiHy9hpi+16LZB+7h2Nd3hGEdW5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sygmedhogJ9jjYATdJ2EpA6aipoX7WLn
	RDKC4J1768J+iy6b1/ixFbP9ZaAzr+IpVi+nH5aL+3wH8xf4Rjc2sojrsLgv97oW
	aMAmbMZt2hUfaPs+63arK60RnZx7xZbWr4DskGZvL9txFbivllMicW1rxe/0qzq/
	Po4m4Wtns3o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77A384D5B7;
	Thu, 31 Oct 2013 16:46:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEDC34D5B6;
	Thu, 31 Oct 2013 16:46:53 -0400 (EDT)
In-Reply-To: <1383211547-9145-8-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 03:25:38 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 932B792E-426D-11E3-9CF4-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237181>

Looks good; thanks.
