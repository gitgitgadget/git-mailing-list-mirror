From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/47] nd/setup updates on pu
Date: Mon, 29 Nov 2010 13:29:25 -0800
Message-ID: <7v1v6324zu.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 22:29:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNBI4-0005Gl-3r
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 22:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab0K2V3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 16:29:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab0K2V3e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 16:29:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 20C0C315F;
	Mon, 29 Nov 2010 16:29:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2Y3KV8Qi7fXC
	rmnBU12MmpX5xJ0=; b=G+LqGjwlyxNy9QphXghRedRA3PkL5IrkvQxOAw/yOr9t
	+l1GTq3fIV062V2qdmBr8ktBsXblurHRKmNXEdFUW3In9Gbw7mZqyRCGfW2zxpFo
	Gzxf4UfVwtGZ5hyS+wHtlz4UVHnkh1VXu+/FCnaDZ9i1i1xxqLT0S1tfU8lRxVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fVcAeo
	ssIEeB4krK8KtvZq9U3z10lFfoTdmJ8Jthi9ibivNyOtYnP9XFBhckI3wi78rVBJ
	+gi8rnn7fokLeskJ7CD7x1pWrB7YuNkI9uCQSEgsVADNl46DswKvlZu6BTsApj9g
	U97ZC1iNKYux0RqG1Nww4TiUULYuyBD3dS5Vs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F3BB6315E;
	Mon, 29 Nov 2010 16:29:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C10B3315B; Mon, 29 Nov 2010
 16:29:45 -0500 (EST)
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Fri\, 26 Nov
 2010 22\:31\:56 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB296582-FBFF-11DF-864D-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162431>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Only tests are updated to eliminate bashisms. Tested on busybox ash.

Thanks for your attention to detail; will replace.
