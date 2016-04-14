From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] i18n: branch: unmark string for translation
Date: Thu, 14 Apr 2016 09:13:23 -0700
Message-ID: <xmqq7fg0i2xo.fsf@gitster.mtv.corp.google.com>
References: <1460543394-11050-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Thu Apr 14 18:19:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqjyy-0005gm-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 18:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbcDNQTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 12:19:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756252AbcDNQS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 12:18:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5471108BA;
	Thu, 14 Apr 2016 12:18:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+ieVf7nsE/jdaewwMEBFK35UU28=; b=FjytAS
	V6GyBwjnNUyYF6Yy980XYDCiLX3TXPZRFIThkLGzsQyfPPLYCz2x6t6764Y5ip+O
	c2Qb5u35Y84fseW/Ts+GVszZmXMciZuDzV+NfTAADOftAjFTaz5Q90UiseO5vu6B
	G3P8G6kxrqeUO9p5NIJwIKxGl5h/gbsvpjTFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aa7B41K34CDrEig8TxmuvrZ28rK29Lt6
	4MTzQVGhZ8OoXwlAJEsMu+nxRDVndZ9QYTNJn8clJiSp9HAFc0+3DhbebLG+aY/E
	amy4kK9GhLc/YWQPuBGsGqkk9R+9TSY4x9ybgsTqrDu3Q/yJ08GaF6BCdOpOGSHC
	FqOZVM3sZ/I=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CD6F5108B9;
	Thu, 14 Apr 2016 12:18:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F27E10768;
	Thu, 14 Apr 2016 12:13:24 -0400 (EDT)
In-Reply-To: <1460543394-11050-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Wed, 13 Apr 2016 10:29:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0DBF3D8-025B-11E6-AC25-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291530>

Thanks, picked up and queued.
