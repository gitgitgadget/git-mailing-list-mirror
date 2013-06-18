From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Move "git diff <blob> <blob>"
Date: Tue, 18 Jun 2013 09:34:13 -0700
Message-ID: <7v1u7z74ze.fsf@alter.siamese.dyndns.org>
References: <1371567530-21811-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:34:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoyrQ-0003KW-2F
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132Ab3FRQeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:34:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933142Ab3FRQeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:34:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F384E293C7;
	Tue, 18 Jun 2013 16:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FvYY7MuMHyffNcx4XEB00HmZNzM=; b=Mtuqtk
	2CEiwgAC8A0l2IPz1X+UHbvdVVGV1C6ffbmdAgQQqIcHpeJyaM07YbkfA1orjJl5
	NaUevIxyEJeQdSxaLQKaW0dus/tVWY2NxIa0k5M7x1dTWBDUaXLOOCUwsJd4/+oT
	4h9aPs13QS4Mc+dVFHZc0VWvR9/420rTRSlyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MnjsEt928R0Lxw/l0BYMrQLHT9lV1+Cj
	EPIsKjrQeAvhCyN42w2LAeFcY+3AYWsxsbn+G+c4EVLwl7N6TcL1Rj7RxKmigX/H
	xpjEN+HoMLBmDyeBFiV+F+aeqmOOppLZO27MtCCmpnRNsX2N/owLVNkXOSS/cSaz
	DCijjEBu6/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFD88293C6;
	Tue, 18 Jun 2013 16:34:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DD66293C3;
	Tue, 18 Jun 2013 16:34:15 +0000 (UTC)
In-Reply-To: <1371567530-21811-1-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Tue, 18 Jun 2013 17:58:50 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA2D79BE-D834-11E2-A5DA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228266>

Thanks, makes sense.  Will queue.
