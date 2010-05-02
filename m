From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] pretty: format aliases
Date: Sun, 02 May 2010 08:53:16 -0700
Message-ID: <7viq76uwpf.fsf@alter.siamese.dyndns.org>
References: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Will Palmer <wmpalmer@gmail.com>, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Sun May 02 17:53:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8bU4-000822-Hl
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 17:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab0EBPx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 11:53:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab0EBPx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 11:53:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E52ACB0A07;
	Sun,  2 May 2010 11:53:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TYQyhQeDFNm33QwiV5L8HbGzyyk=; b=UpNDns
	UBFzlsmv/BQcu/WlfmkazRLCnOwLp74Hxv8huQ0XosSDbR4C8SxxbqnNPenm4Izv
	vbd+5Er3aqJHuvoYQICZVO0f3x8mMvTWetcC461aGUoXAt/CDdhPNtGjdKtKOkHw
	n7xFJ+vPhDvigBenlA1aWQkHBR4Ydb0oU96tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WzAe1KT3TkI1AiBc+nzCGo800vZqLU8r
	S+3N8Df8EHhc6xjgfLgfteupw4JF8MjIPgil3dYcjel2FFuIOnDaJNBSmXEfx5/P
	+JoAvV2alRIcMD6j8qI9mhLUwT4XScgx+Z2gZ/JbWsvhEh3h5CvqlNi5tWj9P3tx
	MkjTfj+zeHU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99B1AB0A06;
	Sun,  2 May 2010 11:53:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE31AB0A04; Sun,  2 May
 2010 11:53:17 -0400 (EDT)
In-Reply-To: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com> (Will
 Palmer's message of "Sun\,  2 May 2010 12\:00\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D613D642-5602-11DF-B106-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146187>

Thanks, both.  Will take a look and queue.
