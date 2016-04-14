From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/26] nd/shallow-deepen updates
Date: Thu, 14 Apr 2016 09:12:30 -0700
Message-ID: <xmqqbn5ci2z5.fsf@gitster.mtv.corp.google.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 18:21:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqk1H-0006zD-RW
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 18:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbcDNQVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 12:21:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964887AbcDNQVE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 12:21:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 189BE139C6;
	Thu, 14 Apr 2016 12:21:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TZcWu48HMyDbp8ZNqwyqRsxqwzA=; b=qxkqEM
	s4PELzE4ZuZU7gIdJOZIOdQdoA5kIlk6++50gXgRtBJw/+bD5Z0S7mMILeFHEzz/
	IfwYv4lOCivM//qvZ+MDR1gxmJ3+VJ6Nvfxul1n5+NzPd7boJqtaLQIsnaVjMnAg
	7bZxjpRpcvdY8wTOduB89g/gV4KNArlKFTdZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eEFBKiXwD1C5cb5erpG5OqIR5OK3MbXD
	XSMLq8lIeXUKGd0y3kbrNKRPpRAFLZx7XS0ehiwSVO2XMZ3kpL9yTrRbc1ba+of/
	D5D5Tg4jAg1giLEQvW3At9KgRihdVqdvomOP8kfnhdtFoOI0APPEkVjMGopMBhfb
	o7Een8QXGrY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 117BA139C5;
	Thu, 14 Apr 2016 12:21:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DC601388F;
	Thu, 14 Apr 2016 12:12:31 -0400 (EDT)
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13
 Apr 2016 19:54:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B144815C-025B-11E6-82AE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291531>

Thanks, picked up and re-queued.
