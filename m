From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.txt: Document help.htmlpath config parameter
Date: Tue, 15 Jan 2013 13:51:12 -0800
Message-ID: <7v38y22jzj.fsf@alter.siamese.dyndns.org>
References: <20130115205621.GB49671@mormegil.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Staudt <koraktor@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 22:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvEPw-0006sB-OZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 22:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905Ab3AOVvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 16:51:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63820 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756351Ab3AOVvP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 16:51:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1106AB971;
	Tue, 15 Jan 2013 16:51:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RstXHKQMUVGu6WuR61f4Py6+PUg=; b=So7ZlW
	d0YXzj9xGcojhSWUmVCZPCnvZMrlXNtyuFQwT6fkjlObwzVpTpF579mLrbXkLj68
	5/iQGzAU17Bx1bDg3kt/7besNyeaB6/JpbaflOuSWzyVaHKP+4r24iiQFoyi4yr6
	dqE5CMP/ZWIf4xK3sbboRqy9CuxdhuuoOr3vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=efcEaUJ2uUmk2yR2E/EQeCfIrFDxaQAt
	+d5j26CeHvlfvVHJZpvmNbB9Hs94IM0mAkN81r+SR4Ncxj/M6wN2AoQ5BmTARDEy
	hC9IvAbCzUEFhm9QcM6nuyxjHB7oUFUZT8Mo5oeb3eE1IqzHPUIVcTTxJPMlfo5d
	dFHmfLxEEaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 036CDB970;
	Tue, 15 Jan 2013 16:51:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79B66B96E; Tue, 15 Jan 2013
 16:51:14 -0500 (EST)
In-Reply-To: <20130115205621.GB49671@mormegil.local> (Sebastian Staudt's
 message of "Tue, 15 Jan 2013 21:56:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEE026CC-5F5D-11E2-A5C5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213678>

Thanks.

This will eventually go to the maintenance track as well.
