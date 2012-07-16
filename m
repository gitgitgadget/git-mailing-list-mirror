From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANN] SubGit 1.0.0 RC1
Date: Mon, 16 Jul 2012 11:55:24 -0700
Message-ID: <7vmx2z1qoz.fsf@alter.siamese.dyndns.org>
References: <5004560A.2030508@tmatesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Semen Vadishev <semen.vadishev@tmatesoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 20:55:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqqSC-0002ya-WB
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 20:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab2GPSz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 14:55:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133Ab2GPSz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 14:55:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 217FB844B;
	Mon, 16 Jul 2012 14:55:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wx1c882jITw53dGi1SMMAELblkI=; b=jT+DP4
	poJPV2prVSCSRxJyFc95CsPv1td+5ZaWDaOwyJhL6dKo3yqv41fxQrLrQdgZjBr2
	b3gcuIq5r09excMiEqc3kCuBxqfP4lkyawtuMe33/soNVKhJxgjUXD0zoG3gxvZn
	fl27jiBJwCs184RdFCh5VNUVR+NrtNL0Y1bgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U9uwE7EoSN89G4BLJds19+jTJMaZfVtH
	CHoDpJjk5cj0WQBemRe/UR+fR3bJNtPSI+nLaWjJfY5bPYr9Lpi3stEKbnh6n3dJ
	394AgFdhuDVUCax+miUIUYaujIfqhSV/EA5Uks6rh19zTg6xQdNe0JDMebEfW+GZ
	Ku+zgJWozJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F611844A;
	Mon, 16 Jul 2012 14:55:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 837AE8447; Mon, 16 Jul 2012
 14:55:26 -0400 (EDT)
In-Reply-To: <5004560A.2030508@tmatesoft.com> (Semen Vadishev's message of
 "Mon, 16 Jul 2012 19:57:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE34F564-CF77-11E1-9DF1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201545>

Semen Vadishev <semen.vadishev@tmatesoft.com> writes:

> Hello All,
>
> I'm glad to report that SubGit 1.0 RC1 is available for download at
> http://subgit.com/

Where's the source?
