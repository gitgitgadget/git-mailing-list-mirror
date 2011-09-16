From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disambiguate duplicate t9160* tests
Date: Fri, 16 Sep 2011 13:41:04 -0700
Message-ID: <7vty8cdxun.fsf@alter.siamese.dyndns.org>
References: <1316202903-5085-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bjacobs@woti.com, rchen@cs.umd.edu
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 22:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4fDl-0006kb-Di
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 22:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab1IPUlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 16:41:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313Ab1IPUlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 16:41:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BBFA555E;
	Fri, 16 Sep 2011 16:41:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=v8Fe2d
	46rw/tE2Nnczs+fZ51BpKALQoB1KjHKf6fb4Ear0ZINMdnVDpyVvKUdmM+c2Ch0W
	/jxlcsjbhzRcbpdVCZZbdPSzwPM8iNh5TDlg/EjnuWyr0r7JlVCOtIcyS93OykRM
	jblMNEo/mpoaAEG5r6pKKhYLjghVoFcmcgSLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MLugIQ51McJ+buRgVDN4wUPOBbQc5ad1
	q1/19WWkyByRwMHUToQXZRlJ8Zteq2p/+zhmRwhkr+0bo7TctjiTEMJAhtSelmXf
	KvcStmkjB3y82GGYw+7wKdYHxNfNBETVD6jo4O4VExI4Lo+tnm82HF6na64/kUaS
	FW4siaHrYEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 536D0555C;
	Fri, 16 Sep 2011 16:41:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E04BF555B; Fri, 16 Sep 2011
 16:41:05 -0400 (EDT)
In-Reply-To: <1316202903-5085-1-git-send-email-frederic.heitzmann@gmail.com>
 (=?utf-8?B?IkZyw6lkw6lyaWM=?= Heitzmann"'s message of "Fri, 16 Sep 2011
 21:55:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33320CB8-E0A4-11E0-9D1C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181554>

Thanks.
