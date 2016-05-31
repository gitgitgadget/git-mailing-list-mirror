From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] README.md: format CLI commands with code syntax
Date: Tue, 31 May 2016 08:54:37 -0700
Message-ID: <xmqqzir65iki.fsf@gitster.mtv.corp.google.com>
References: <01020154ffa221f6-c45ab36e-cc26-46a8-b2fa-2c40e54959f1-000000@eu-west-1.amazonses.com>
	<vpqbn3odqs9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Benjamin Dopplinger <b.dopplinger@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 31 17:54:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7m0C-0003zt-W3
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbcEaPym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:54:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754925AbcEaPyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:54:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A1A11E1CD;
	Tue, 31 May 2016 11:54:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M2Tp9RNLZHb3g/nBmBeK78X/loI=; b=B3eEWt
	M8A6lvFmifT2EQHqa0GU3WYBpx0jzAdPlliFRRinje01XFWDG53v4G9gH3EMK08T
	/jDKdeyGFb3sr+FOxCRx7DOaN6xB6oJX3ZF7qcApEAY8JFYZjXRxW1S1lXJ5GgH0
	eFNdBTX0aH1oyN/DyT+jMZL+uRnqmxAtmhJ2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=auEzbQQfvS53RUasW9sVhpnIKQEBnH+R
	cRXmSfNVuYr2oIZbb/dQbwy9LFsW6+feQqRXVAS/WxENPkdzaF9NvKEx0SPTZ5/I
	GyNyxpL4RSDgEpYgRJNTEQotHrlHQLy9WGjMQFT5eROVTycVtO5wzkDnYZVwD4b2
	EzDDPcqrgvU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 920EC1E1CB;
	Tue, 31 May 2016 11:54:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EA671E1CA;
	Tue, 31 May 2016 11:54:39 -0400 (EDT)
In-Reply-To: <vpqbn3odqs9.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	30 May 2016 08:05:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB29F1D8-2747-11E6-A8C5-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295988>

Thanks, both..
