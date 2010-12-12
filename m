From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull gitk.git master branch
Date: Sun, 12 Dec 2010 15:20:15 -0800
Message-ID: <7vwrne8tow.fsf@alter.siamese.dyndns.org>
References: <20101212063135.GA7677@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 13 00:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRvDU-0003rp-UG
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 00:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab0LLXUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 18:20:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab0LLXUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 18:20:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7ACB92CD3;
	Sun, 12 Dec 2010 18:20:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hMlLkpSzoBcRnEmxd80Pr786ZSs=; b=O2bB5T
	Vmoqf+Z94MvnZ/Y1gXDnNXH8DFaS8IemmbpGbQRfeUjGfRFjr5mwqgusIX7qeQNY
	LtK1VuVHhshAtKKX4pwY9D8RTAP2/EI89H27rAB0HQCbX/K8yt+6WspWxxaFDkP6
	6yNvxGii8+VXvsUHEG9BeWSiT6Ofg93rsIez8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oim80B5VA6Q1YK7XgPArn6XNmr5x/WtV
	hO6cSSea6+Ifz9SIIkvxvs0e2SZzQDJZvaMfxHW3plqTpbcy/2Wd2baBeVrgP84S
	8R08GjfDJUlesDZsBGE0incRl6MLr/2XFx9EqS/ZiEqJ9CwcsejPzrTHAN8bOmjf
	GcdkQFSDFHg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5742E2CD2;
	Sun, 12 Dec 2010 18:20:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 762192CD1; Sun, 12 Dec 2010
 18:20:43 -0500 (EST)
In-Reply-To: <20101212063135.GA7677@brick.ozlabs.ibm.com> (Paul Mackerras's
 message of "Sun\, 12 Dec 2010 17\:31\:35 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72B71042-0646-11E0-84E9-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163496>

Thanks, pulled (not yet pushed out).
