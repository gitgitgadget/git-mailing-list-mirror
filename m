From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.9.2
Date: Thu, 01 Mar 2012 23:15:26 -0800
Message-ID: <7vobsffp81.fsf@alter.siamese.dyndns.org>
References: <7vbooq6zq2.fsf@alter.siamese.dyndns.org>
 <loom.20120302T070513-878@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Wm9sdMOhbkbDvHplc2k=?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Fri Mar 02 08:15:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3MiK-0006Lb-N4
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 08:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012Ab2CBHPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 02:15:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964869Ab2CBHP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 02:15:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CAAA74EE;
	Fri,  2 Mar 2012 02:15:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ucjd8bUfVUdy
	i03hr2BDqXhlTUo=; b=XaSVAm0ZUiHOZFPWwY4RnRPX6wdx6Ic+vGHZfJuhvg0g
	XcISQaFXwH0uQ2QaSUcOchKpqmJCnqryw4svuVGevYW5Y24Om4f3dKCT9He76w2N
	L1ZSV9ywdx0Tf5+M4Ia5ka9Hlik1WH58M9KTapPNdBLYwl3PdXAvRSRl0OXLAWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g+U2ql
	eSoIJl6Xj7nHEux/eLbTMiFn4fH+2WPFu0STAo3iGmKM9GquK6etnaROXQAaLvSV
	yvT3maLpIlhN14cNnl4QBOjTh/A+dbSphU4j53El1zMs3Z8ivxQ/TCI3RuIGaomA
	I1M3ZTnk8fmV0kmXXukGNre2sdwDHLrcY4pRc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6481974ED;
	Fri,  2 Mar 2012 02:15:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA42E74EC; Fri,  2 Mar 2012
 02:15:27 -0500 (EST)
In-Reply-To: <loom.20120302T070513-878@post.gmane.org> (=?utf-8?Q?=22Zolt?=
 =?utf-8?Q?=C3=A1nF=C3=BCzesi=22's?= message of "Fri, 2 Mar 2012 06:09:19
 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CECE44C-6437-11E1-AAD7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192010>

Zolt=C3=A1nF=C3=BCzesi  <zfuzesi@eaglet.hu> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>
>>=20
>>   url =3D git://repo.or.cz/alt-git.git
>>   url =3D https://code.google.com/p/git-core/
>>   url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
>>   url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-co=
re
>>   url =3D https://github.com/gitster/git
>
> although https://github.com/git/git is not in the list above, I've ju=
st noticed,
> that v1.7.9.2 tag is missing from that repo.

That GitHub repository was having a hiccup on that day and did not allo=
w
me to push things in there, which was later fixed.

I just updated it.  Thanks for noticing.
