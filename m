From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.9.1 tarball
Date: Thu, 20 Mar 2014 00:18:36 -0700
Message-ID: <7vy505tk1f.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6Tgu6soDQXcnh=1htz_mv9ESF_KDhFRrcijZyEWeCHnpQ@mail.gmail.com>
	<CAEjxke_zZrrkvQ+2cL9m0kgJTVVxVz=WmQcz8_sQKoggHwO4Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>,
	git <git@vger.kernel.org>
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Thu Mar 20 08:17:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQXEL-0005Pv-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 08:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbaCTHR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 03:17:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbaCTHRZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 03:17:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD7026AA69;
	Thu, 20 Mar 2014 03:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=g2vv68KBVryU
	HzDUBQxKhj0LgD4=; b=Y7xI+rk71GQfwAfQLWmdPcMYPwNi4S5TJYUTVJ3WSysy
	w729QsOQlLgpJi3kLe8DNwxQrdywz9hn1cLKxXre88nA/PgnJx0OR1ddmmEngYOt
	5yYfbGyREn+TU5RQaBj3Rjr1NxwS12eOLbKF+6+bXTQkprvpb80etmcRT74BdT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=q6yuT0
	bRv6yrzXIkmrwKyA+xdsR0dx2RreLnRXDdC2L+upwWMZy+0KWBoi/4QtJEVh33IK
	JbQV+WG1QSiyb5U/4X2x40Uz8JUpPIoUI38aqs9C8hbZvaRBg12eTaN1jjSSYen/
	bLW1UqFGD1u09aYvu15uhN8pO4AklkCKDD9gg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBB896AA68;
	Thu, 20 Mar 2014 03:17:24 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D70EA6AA65;
	Thu, 20 Mar 2014 03:17:23 -0400 (EDT)
In-Reply-To: <CAEjxke_zZrrkvQ+2cL9m0kgJTVVxVz=WmQcz8_sQKoggHwO4Eg@mail.gmail.com>
	(Jason St. John's message of "Wed, 19 Mar 2014 23:28:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: AF01FD08-AFFF-11E3-A012-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244521>

"Jason St. John" <jstjohn@purdue.edu> writes:

> On Wed, Mar 19, 2014 at 8:09 PM, =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cool=
i@gmail.com> wrote:
>>
>> Hi,
>>
>> Where to find git 1.9.1 tarball?
>> It is not uploaded to google code.
>> --
>
> You can download a tarball for 1.9.1 from GitHub:
> https://github.com/git/git/archive/v1.9.1.tar.gz
>
> Jason

The announcement message starts like this:

    The latest maintenance release Git v1.9.1 is now available at
    the usual places.

    The release tarballs are found at:

        https://www.kernel.org/pub/software/scm/git/

It is somewhat strange that nobody seems to read the announcement
that has that exact information before asking.
