From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enhance git-commit doc for multiple `-m` options
Date: Wed, 27 Mar 2013 09:31:53 -0700
Message-ID: <7v620colc6.fsf@alter.siamese.dyndns.org>
References: <20130327141935.GE2940@genode-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Helmuth <christian.helmuth@genode-labs.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:32:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtGy-0003Tx-3H
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838Ab3C0Qb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:31:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718Ab3C0Qbz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:31:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E0AA920D;
	Wed, 27 Mar 2013 12:31:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Eqllfe
	UP2EJ8KCKgQEjSw7lrg0IO1CS1a+s1YXWVyLxscavW63yr0w3rX//It2sUANA7XJ
	YqvLP6Lwxkt2aKF9I3NnKPFOIUCxPWnpIYQhhVbuI2mrSU3VYfHENFkIs98JYxng
	rb4lzDpDnOA0eQ+YxXbVa5pfbeu1MARWUcb8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iy78HYhorU+VOV934eZjQWq4ylqfaq9F
	suCVxBP3iHYPD9ffMTz+Q+dneVaIYejvvNShhOghEzFjT3ANs/CalQ9GVZbrYUkN
	SjtdWYJO0uLfYfJnJsnxb764e0Erv5TJTDSWi3OLpOAojINwgcxE0q3FzSONoY/p
	fqvoTdHAohI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41EBC920C;
	Wed, 27 Mar 2013 12:31:55 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2B79920A; Wed, 27 Mar 2013
 12:31:54 -0400 (EDT)
In-Reply-To: <20130327141935.GE2940@genode-labs.com> (Christian Helmuth's
 message of "Wed, 27 Mar 2013 15:19:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6182E08-96FB-11E2-AAEA-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219271>

Thanks.
