From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: fix alphabetic ordered list for
 git-rebase man page
Date: Fri, 23 Mar 2012 12:28:10 -0700
Message-ID: <7vd383t8vp.fsf@alter.siamese.dyndns.org>
References: <4F6C5F1B.6010603@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Mar 23 20:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBA9s-0001zk-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 20:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758165Ab2CWT2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 15:28:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756090Ab2CWT2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 15:28:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59ADA60CB;
	Fri, 23 Mar 2012 15:28:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z5lywzcgjkIjZBHi7K3kIKjY/KY=; b=Cqccuv
	5XN6BBAUP3i2MS9pJO81HrvjKy7DIUcyzr1LAQlSm9pv6/OCNqpGN1g78YWi4E28
	RlmSI9aduwsT2TPnGi+gCqa2uR/VJYmJP3kulDODlMVxmUvfrneIF0lK3+SbKwar
	3JvSd95wjPS8cxQ9YC3MTxzOQ39wIOrVY6wDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pr+vKuVVaAAfKJ59YtI1RB98Kpfu6qiM
	5PcxCqdgLA07q1liwuCKQykf0Zl1GwnpsLbeL8aJ7v4Z5nhRLrv0s7nDbxjt8vAJ
	Gfxxq9rchXl9Z5rl15t38OXlAJcbsOe0DGjry4DBkYnT8mmWbuPRnmzCsaQ3kGE1
	qXLBz/CUsek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 509E560CA;
	Fri, 23 Mar 2012 15:28:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BC9E60C9; Fri, 23 Mar 2012
 15:28:12 -0400 (EDT)
In-Reply-To: <4F6C5F1B.6010603@seap.minhap.es> (Nelson Benitez Leon's message
 of "Fri, 23 Mar 2012 12:31:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54474A4E-751E-11E1-B461-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193795>

Thanks; sign-off?
