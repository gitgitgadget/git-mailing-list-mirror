From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Date: Sun, 16 Oct 2011 00:24:49 -0700
Message-ID: <7v39ets8ji.fsf@alter.siamese.dyndns.org>
References: <7vr52s9ny5.fsf@alter.siamese.dyndns.org>
 <CAOeW2eHdOQi=fqzm6A_dzbMCXFo=FB1JFBe21KQL5vypCG8jeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 09:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFL6Z-00059i-Gg
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 09:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851Ab1JPHYw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 03:24:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376Ab1JPHYv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 03:24:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07ED44354;
	Sun, 16 Oct 2011 03:24:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UpqHVRXRQVsW
	7EOXGnPCeCwBzBM=; b=IqPeTDIPr1xo7f6/5Gnt8M0QIxNqVmzD0hxh3uUBPvHS
	VCK+X9o0nkXBPKw/rN9+ID4chWssXMkhnSi027KXIzHBUgOgHsTyy58NcTk8aTz6
	VcFtiQX/5tlAPvFLu6CR/kbKAA6zbtO0qYbRiR6HKn5y1JiVCAuLONW7GGux3CM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=c8AKkq
	FPuRmixx0HzQjDjEbbmwWP0/ta9VQdRST75gDXi0P2lMix0ARGJsPgn/D3f5PANf
	B4CXaJGzb2FRayNU7Gy2jirCnLVyKG3nWV3IN1SGAYBy1q8YBaH7aWIvyOOIzp7F
	MJt1GbHgyHo6OmJrLUxsGZ9hbJRxnFI4dPW0I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3C444353;
	Sun, 16 Oct 2011 03:24:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88D964351; Sun, 16 Oct 2011
 03:24:50 -0400 (EDT)
In-Reply-To: <CAOeW2eHdOQi=fqzm6A_dzbMCXFo=FB1JFBe21KQL5vypCG8jeg@mail.gmail.com> (Martin
 von Zweigbergk's message of "Fri, 14 Oct 2011 22:47:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF417F4E-F7C7-11E0-9340-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183694>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Tue, Oct 4, 2011 at 7:22 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> =C2=A0- gitk-git/ comes from Paul Mackerras's gitk project:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git://git.kernel.org/pub/scm/gitk/gitk.gi=
t
>
> I don't seem to be able to fetch from there. Is it still supposed to =
be there?

Unfortunately k.org is _slowly_ coming back to life.
