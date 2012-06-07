From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Thu, 07 Jun 2012 11:03:43 -0700
Message-ID: <7vtxyngfsw.fsf@alter.siamese.dyndns.org>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <7vr4u23f0i.fsf@alter.siamese.dyndns.org> <20120529203759.GC22151@burratino>
 <CACsJy8AGKQHKx9XU+baUagcmi6Sc-=faNshpED=Q46JpV_31WA@mail.gmail.com>
 <20120602124440.GA28996@burratino>
 <CACsJy8A+FTjD3dzBWtL7X35YE9E3t0Gcx-DA6T_+Nt=X3Wp1jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:03:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sch3m-0003D1-Kx
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 20:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab2FGSDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 14:03:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056Ab2FGSDp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 14:03:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51FCD84B0;
	Thu,  7 Jun 2012 14:03:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dbGy8HRU6loh8rU5bbvrRiWTEwM=; b=tykuoi
	pX94ineZ/OLp4Szs/UeBboxF65ZxXIDBf9NC+ma3tf/E4LTNZiUha/JDHbRKmA9r
	iSnQ7B7OKcuoCGmtGz7ygoJrAmQny/ooKHUVfZuqfFr3ITM1jIvjTOYizdysohT6
	0VvgmIbwAESJuFibezP6QxbvY52nCi28IC4L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DXVrTGYrgavA5cKCIzvEUQokQ80E8E0G
	TqzXdQueGKF/iFmJ+Sg+Kwi7rz7SO4DLqrTJFyKc6NcqliB7aulqd32Erw4y0E8T
	8KIWQRq9yM6Sgi6mrBukikE7hBLO2qyBQMIRJTMrKMkF2BIDlP29I6ypBbd8ybBt
	EQjfANZrVSk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4887F84AF;
	Thu,  7 Jun 2012 14:03:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D254C84AE; Thu,  7 Jun 2012
 14:03:44 -0400 (EDT)
In-Reply-To: <CACsJy8A+FTjD3dzBWtL7X35YE9E3t0Gcx-DA6T_+Nt=X3Wp1jQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 7 Jun 2012 19:31:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F5B1408-B0CB-11E1-B5F3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199431>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> No changes to the series then. Junio, pu material perhaps?

I would say it is a post-release material.
