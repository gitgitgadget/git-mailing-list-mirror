From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify help message when no remote is specified in
 fetch/pull.
Date: Tue, 27 Jul 2010 10:36:48 -0700
Message-ID: <7vlj8w7rnz.fsf@alter.siamese.dyndns.org>
References: <1280161929-18620-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 19:37:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odo5M-0007q2-66
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 19:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab0G0Rgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 13:36:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0G0Rgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 13:36:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F316C8A5A;
	Tue, 27 Jul 2010 13:36:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=l5+rSCd5qgjxnU+T58GstH4V+Js=; b=YQs7FMAqhcXlP7mbFhpm/ES
	v5hh/b8yLYTwrveeYkaCoDm2pP407ZtngJHtzLfgS875vSK8J37VHkK+btf+1tYG
	Xkn7nTdDr5cMi3XXDx0q2wup2h1lZ6XgrWa5XKc+KbEXDbK2lHVSEUk0tfNGF5qf
	Trs6KAZ21ePpN1OdtqO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ihTgAk0UPhySTHYTlbYk8syZnN6QSy/FOFjZpbAdxnnqc3QJt
	VUzqYVH2kh4zfhO+D1VRJgY3eLLK1lBZLDQMrsnUiYMQvS2F7+JW7CdQS2PUJFLQ
	gMOsAiYJ+/0TNPe/NwIbs0+EwTxx24AmI32ZdYxU0z491jdIYe6Sy4HyyA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A2EAC8A57;
	Tue, 27 Jul 2010 13:36:52 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB95BC8A54; Tue, 27 Jul
 2010 13:36:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8AE67AC6-99A5-11DF-BCB0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151964>

Sounds good.  Thanks.
