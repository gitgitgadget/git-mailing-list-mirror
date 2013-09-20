From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5541: mark passing c-a-s test as success
Date: Fri, 20 Sep 2013 11:18:11 -0700
Message-ID: <xmqq1u4jqrvg.fsf@gitster.dls.corp.google.com>
References: <20130920102459.GA26914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 20 20:18:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN5HZ-0006ZY-45
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 20:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab3ITSSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 14:18:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160Ab3ITSSO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 14:18:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9744D43813;
	Fri, 20 Sep 2013 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=DwyH5g
	Ek9pkQ7RKql8kzzbTYVUohO33AbJvvOFh/b5lZeicq7UmeoJAH6YnB9sYdBiOpGS
	BoxBt3BJd5a5bAeRLHNaDVRzE6o6/Hsfp6N2Jit60ipnAi+y+mCqkJT7TK/z91Z6
	XHATg3UYioaaskXsmDkZjSmG+8sNd2qj6BPf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qfZjVcw/D9p86Tw9Lo3cT4tFbh4UfsNp
	27tI1DpY4lVL0VaTGgoIhOSXO9FfK81M8nt4/zVeZkqeDG8uydVjf9fAVroQIBmv
	DihTjuja8FQHYX0K2X54bpza6pIyhXk8vhWIiq53tfE5W4saadpsKdIKkQH11eXw
	/eja0mihAoQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CFD043812;
	Fri, 20 Sep 2013 18:18:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0650143811;
	Fri, 20 Sep 2013 18:18:12 +0000 (UTC)
In-Reply-To: <20130920102459.GA26914@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 20 Sep 2013 06:25:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 02F8594C-2221-11E3-ADE0-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235075>

Thanks.
