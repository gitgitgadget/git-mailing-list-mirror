From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed translation error in config.c file
Date: Wed, 06 May 2015 15:30:10 -0700
Message-ID: <xmqqpp6ds5jh.fsf@gitster.dls.corp.google.com>
References: <554a8472.8c3bc20a.458e.ffffdae7@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 00:30:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq7pa-0007fk-Hl
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 00:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbbEFWaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 18:30:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751292AbbEFWaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 18:30:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 300FD4FA8E;
	Wed,  6 May 2015 18:30:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vZIyA3mf6Stb9cFbkb7QsPU7OBM=; b=W81gMi
	SoDY7pl8bHv0vDni+c3XUHY08C4NRQF01VZ3RNBydekbc/OUeAGJDaOjwVTkBL4x
	KWQUxx+7X/i+Xcsgta0pB62DpMg4Bvfzl8JD5phIAeIgmEimg/soHdRl2MptBSN+
	H2LKPixcU6tkyryS8VmFGRloEQJWQ/3Bwij5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VDG07wFm3UNd9/R4rbPj1N4C9xUGlIKQ
	rJqGOijzBQHkMka0RPztmxD7ecOpwFfNCl36hJzq/eZQQqor8N9pTbgZhbRwJ9J6
	QYnodZz+RgAkjghJa9zEB7pWkyyS3v40h8kWxiWdaTS2+EnQhzjm6eVjMoltNmmp
	12DO46bjO5k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 269184FA8C;
	Wed,  6 May 2015 18:30:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F2E14FA8A;
	Wed,  6 May 2015 18:30:11 -0400 (EDT)
In-Reply-To: <554a8472.8c3bc20a.458e.ffffdae7@mx.google.com> (Alangi Derick's
	message of "Wed, 6 May 2015 21:51:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75563BAC-F43F-11E4-AA3C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268501>


>> Cc: unlisted-recipients:; (no To-header on input)

Not again X-<.

You are sending this to a single recipient which is the mailing
list.  Send it "To: git@vger.kernel.org".

>> Subject: Re: [PATCH] Fixed translation error in config.c file

Ehh, how many times do I have to say this is *not* "fixing
translation errors"?

maintainer starts wondering if he is deliberately being ignored, and
stops reading...
