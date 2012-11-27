From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Fix grammar
Date: Tue, 27 Nov 2012 14:02:52 -0800
Message-ID: <7v4nkan1pv.fsf@alter.siamese.dyndns.org>
References: <1354038279-76475-1-git-send-email-max@quendi.de>
 <1354038279-76475-4-git-send-email-max@quendi.de>
 <7v8v9mn5k6.fsf@alter.siamese.dyndns.org>
 <5F2BC41E-6F77-44B8-B05E-8FB07E82EFA3@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 23:03:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdTFG-0001ex-V8
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 23:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab2K0WCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 17:02:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483Ab2K0WCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 17:02:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 388C1A0C1;
	Tue, 27 Nov 2012 17:02:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VT8muB9TpiNnooP7qL0KFvL6Ppo=; b=RRdotm
	ZLM9Bk/YiY+m7KdShgFjFZDiQINGnhYU38kQBjjFeLbNIrT/NeXJPCjle4mT6Awt
	FQjVr0En6xqywO4G20Xgj/oIJTrxThSR96HHBuU20viF+sDj7Y3rfKSoX3GUMF90
	MRik15DsAAhY5AblFCdUA8M1hp7b4x7RE/tmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sqvh8xr9gfRur6MNybza8xhYWKTEN0m8
	blaHRoJDJZtM8cNSLlgjFoRLMU6bpknPhDcX2pSfw+J2LwdT4ZChgufAk5jGm064
	2qq4gFY2+jNppUk63MnfxTMG/oKlZLnuvf2j6Iaf1jg+gkxh/g/Gda7ye/1YG/MA
	bJExKhkUXVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26145A0C0;
	Tue, 27 Nov 2012 17:02:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CEF9A0BF; Tue, 27 Nov 2012
 17:02:53 -0500 (EST)
In-Reply-To: <5F2BC41E-6F77-44B8-B05E-8FB07E82EFA3@quendi.de> (Max Horn's
 message of "Tue, 27 Nov 2012 22:23:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 315B6040-38DE-11E2-8952-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210609>

Max Horn <max@quendi.de> writes:

> If this is indeed it, would a commit message like
>
>    git-remote-helper.txt: minor grammar fix

Perfect.  Thanks.
