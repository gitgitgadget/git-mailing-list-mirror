From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] git svn updates for master
Date: Mon, 29 Dec 2014 10:15:57 -0800
Message-ID: <xmqqtx0ez5ia.fsf@gitster.dls.corp.google.com>
References: <20141228094554.GB29140@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alfred Perlstein <alfred@freebsd.org>,
	David Fraser <davidf@sjsoft.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Dec 29 19:16:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5erf-0004BR-8d
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 19:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbaL2SQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 13:16:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751597AbaL2SQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 13:16:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97D2D28B42;
	Mon, 29 Dec 2014 13:15:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=nlbApG
	+N8vQQn5x9sCWvCRfRd6yr2Zz93U8rCbxf5C+SMoQFWvqBHcgOn7PuZmi6EjV42T
	6VfPlexfAwQU/lVrffmtsyLKPRoip73MUrD4UYIitmJ86waC4lrAiMovXCS+78Q/
	NvU66WjdIN3DAC1swrHwdBqRO/NXdF//lVcws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jVw3/7OVaqK/RCBnJARAzNs6jai3DYlR
	PiJx9bahRN1aXNO73GTkwGYLVXjUGP9YusMdAakKSpyHO1x2j3HOKTJizxfmv7Pq
	q5bb8xBEguZJnLa6Ot32KcZABJTDytjewEcVjp+fXwJiEGNg9Obywj+uqDrWiiB6
	M7j6Rvc4iRg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D66128B41;
	Mon, 29 Dec 2014 13:15:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1433728B3E;
	Mon, 29 Dec 2014 13:15:59 -0500 (EST)
In-Reply-To: <20141228094554.GB29140@dcvr.yhbt.net> (Eric Wong's message of
	"Sun, 28 Dec 2014 09:45:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD3889F2-8F86-11E4-8622-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261871>

Thanks.
