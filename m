From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][GSOC] Proposal Draft for GSoC, Suggest Changes
Date: Mon, 31 Mar 2014 11:04:02 -0700
Message-ID: <xmqqfvly6y99.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRdxHz8VVT+iRaNSrj=EdpAFO2kjOhJ-++S9hODwDFmGg@mail.gmail.com>
	<CAOLa=ZSzJMS=mx1tNYPjup0b5DCDVoxuCJPXAwDUo3tQTe-neA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:04:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUgZ9-0006wq-25
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbaCaSEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:04:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbaCaSEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:04:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77B6076856;
	Mon, 31 Mar 2014 14:04:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eptZ/0PR9yEGdKsOa90BFz/INAY=; b=te0GGa
	VrgJYEmpbKn2FEIKcJ6PiM9r9G2mpvN61E6zROL3RSjoHva70BZtWFtFUyjHyzbO
	RzlGqLyM0NKk1s8xtDB33NhKeHgjpcH+8bH6Axsu77kbjwlZySwCeK9STpvoYG3a
	gpdqWvRhDrhFA3sBR2RhCdnrlK7+6Qvk37Cq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i0kKCL9BMTMpclXbRFjOmlGWEXQDMzDw
	dvmtBGIncZMUGi8+Rgn8MJP8hqXoAQ59KlkIxf2nLYhD18nJ7YfVnBU28+OZq32g
	ze8+MxS11tpBr3/Umqz2WSiEwD2E2QIHd5++y0nVBTpKjEG0Xc71dE5lC/IaqUvc
	BcTBVCwa3iM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58B0976854;
	Mon, 31 Mar 2014 14:04:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B331F76853;
	Mon, 31 Mar 2014 14:04:03 -0400 (EDT)
In-Reply-To: <CAOLa=ZSzJMS=mx1tNYPjup0b5DCDVoxuCJPXAwDUo3tQTe-neA@mail.gmail.com>
	(karthik nayak's message of "Mon, 31 Mar 2014 20:42:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D810CFDC-B8FE-11E3-A559-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245502>

karthik nayak <karthik.188@gmail.com> writes:

> if there is any way
> where i could contribute to git via bug fixes or something similar

Yes, it is called the Git mailing list, and you are posting to
one. ;-)

This project works primarily with "scratch your itch" principle.
When you see bugs or room for improvement in an area you are
studying in preparation for GSoC, you are welcome to send a patch
series to address them, even it is totally unrelated to your GSoC
application.

Thanks.
