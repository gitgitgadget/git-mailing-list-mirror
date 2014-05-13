From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Tue, 13 May 2014 11:27:53 -0700
Message-ID: <xmqqsiodo7o6.fsf@gitster.dls.corp.google.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
	<1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
	<xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
	<536d4e7ba8ea_585ea5308a9@nysa.notmuch>
	<CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 20:32:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHUl-00039l-Ib
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbaEMScB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:32:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58418 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754058AbaEMScA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:32:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAC3816FE4;
	Tue, 13 May 2014 14:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vyUGhfr4BmJEozqMhrkHoB/CCGI=; b=UMCeGZ
	xF6ylHLvtN7vQBotE5gHpBvER97PDWd8+rBDlfDQ0MajBbxW9BTxtM6iBXNxhvdR
	e3AEZDKRRJgTI9eGvZZH6XP3a0LEpEtpphsswhtU2rYWtFCwKM6r1j/y2n8bI7cN
	QVtp8gtiCdSa7398BhSKQUIK8p0BBHvZepK/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GsBLfTjYH9a1QByNgQNKHDlD2xOPaaSC
	G6gVyWU9DL21aEnLMg8j1ywpCWVTtmPPJH8EA1eCPo3C5L6vEdJHh0Dba1UbFw9I
	9g6gRZ1L8m2zsYYb4J22F/lmZBCrsCiythg2GvxxMpjY/kqZ9p7fjoiKic2l0Rpb
	73MD0YLWZrw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E45F16FE2;
	Tue, 13 May 2014 14:31:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 92A0A16CAA;
	Tue, 13 May 2014 14:27:54 -0400 (EDT)
In-Reply-To: <CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 13 May 2014 14:10:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4CB18F9A-DACC-11E3-A33E-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248799>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Fri, May 9, 2014 at 5:54 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> You are once more twisting the sequence of events.
>
> Found this gem looking for background to the proposed removal to code of mine.
>
> Felipe, if you are wanting to have a war of words with Junio, go have
> it, with him.

Please don't feed the troll.  I was happy to be done with it.
