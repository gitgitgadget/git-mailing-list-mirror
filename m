From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.9.2
Date: Fri, 02 Mar 2012 10:54:56 -0800
Message-ID: <7vvcmmde9r.fsf@alter.siamese.dyndns.org>
References: <7vbooq6zq2.fsf@alter.siamese.dyndns.org>
 <loom.20120302T070513-878@post.gmane.org>
 <7vobsffp81.fsf@alter.siamese.dyndns.org>
 <loom.20120302T153452-583@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Wm9sdMOhbkbDvHplc2k=?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Fri Mar 02 19:55:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3XdD-0008J0-GB
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 19:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115Ab2CBSzB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 13:55:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab2CBSzA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 13:55:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F88C6838;
	Fri,  2 Mar 2012 13:54:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=s+GRvFnP9mVw
	C3EHdxx9NQHV0kc=; b=V7AwtcoqaLWIEWm6Isv8M8SL7/FuHNhRSfSVx/iRca8P
	Ww/unyAYIOHh5iKTudwyEiDc+BtiBa+9ad/iYRErPub5hQ9gTcvllZgdimcMku/O
	PkC8MD8Sq7818dfESYtJr5M4Ck+HUsaugNR4tEMMcuaCb9SV0tOe2NbkhyzNCRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Tk6vQa
	poOwJhGknCAk8+800BY0okvZv6GOkjCV9IHeWK5YRPXaDBaGDC83zNXQblGnD7Qj
	5fZbbrlms1LD04r+1SjXVbHIHmRsmmW5kIMsopUDKyC5ZeSPZTdcifayPdAtQWKy
	zTNgLUWXuJkuIS/FCEmlW7lw1SFeT/cG+IlzQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 662A66835;
	Fri,  2 Mar 2012 13:54:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFA0F681F; Fri,  2 Mar 2012
 13:54:57 -0500 (EST)
In-Reply-To: <loom.20120302T153452-583@post.gmane.org> (=?utf-8?Q?=22Zolt?=
 =?utf-8?Q?=C3=A1nF=C3=BCzesi=22's?= message of "Fri, 2 Mar 2012 14:46:25
 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3502072C-6499-11E1-A543-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192062>

Zolt=C3=A1nF=C3=BCzesi  <zfuzesi@eaglet.hu> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>>=20
>> That GitHub repository was having a hiccup on that day and did not a=
llow
>> me to push things in there, which was later fixed.
>>=20
>> I just updated it.  Thanks for noticing.
>>=20
> I hate to say this, but I still cannot see the tag.

    $ history | grep push
    12360 git push -n github2 v1.7.9.2

=46acepalm.  Now its time for me to find a brown paper bag.

Thanks for letting me know.
