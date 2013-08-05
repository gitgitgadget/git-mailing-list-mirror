From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log doc: the argument to --encoding is not optional
Date: Mon, 05 Aug 2013 08:50:15 -0700
Message-ID: <7vzjswm91k.fsf@alter.siamese.dyndns.org>
References: <20130802221640.GA7478@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:50:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6N3L-0003Fy-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab3HEPuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:50:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547Ab3HEPub (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:50:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F0A536677;
	Mon,  5 Aug 2013 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=qQFTSa
	aLtqD9SPORxLbXXk3zMB5S0bDFD+lOHofLGabjooKmO0zwRtsS00+Qi1RhvX/zVy
	GV08ZKTj9Ntsdd7+TyghKzn0ZBu8k7WPg0bm8ueANLnxcyVDOr41VbLbwZYn/P1r
	DPIET+mz9pj+SoXmKXbpYrJfUgpwwNF9irxno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLDiLTE0RS1+S7jTSzG1ioJJVewdvOSh
	pxO1OrNb+LizKffkMhME2HEnOJIIe1qZbx8C9nqgd5Gi5EAdMHURIvZajes/mkoN
	bvUPdvLQtKhbtl74jnoNB9MyvkSFS4Jium3QH9KY0JYz8WuSnkcAtFilbLf6Xc4G
	x7cmo0oMI3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53A2E36676;
	Mon,  5 Aug 2013 15:50:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5CE43665D;
	Mon,  5 Aug 2013 15:50:16 +0000 (UTC)
In-Reply-To: <20130802221640.GA7478@elie.Belkin> (Jonathan Nieder's message of
	"Fri, 2 Aug 2013 15:16:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9552800-FDE6-11E2-A1A8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231660>

Thanks.
