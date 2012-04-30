From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] git-commit: remove lego in i18n messages
Date: Mon, 30 Apr 2012 10:54:52 -0700
Message-ID: <7vvckhf6kz.fsf@alter.siamese.dyndns.org>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
 <1335799995-7667-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 19:55:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOuoO-0001s7-JA
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 19:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756333Ab2D3Ry4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 13:54:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920Ab2D3Ryz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 13:54:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B758F60D0;
	Mon, 30 Apr 2012 13:54:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K/uxrFax1cG+v6DOseKqB6SQ1Bs=; b=EgmCpW
	lrF6FjVKPdHgBykovtHhoAHJ/TK/hj/qNiWAjVy7t0pSJfFSmo5NeQMRU26KCZ5M
	rKL2KCwOjwbYGDKq63x06M2PL9KOpiVBBfYU0KjPtro2yse4KwiZxeU6y3ph/aCj
	+U9gQQjxJ5KFgJKeBVXr7aKYsB3ixmYpHC+fE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xtf9jY2aqej7Ovf7cGPETPD/F0oCLYKX
	AvjDMvaplYiqZRrZCkd0DieiS0Ox6fT6XSD7Q7Sw07sNkVmaV1IVs7pTvBzjVDev
	TvVNb7R3zsGQ9YX154mfcyO74Og5FDstzbwC+XyPpVhtXOOsUF3UqPdVwas9lEeh
	/QpuJETzB3I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE1D460CF;
	Mon, 30 Apr 2012 13:54:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 454AD60CC; Mon, 30 Apr 2012
 13:54:54 -0400 (EDT)
In-Reply-To: <1335799995-7667-6-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 30 Apr
 2012 15:33:14 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9768B564-92ED-11E1-8F2E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196585>

3, 4 and 5 looked all great.  Will queue them.
