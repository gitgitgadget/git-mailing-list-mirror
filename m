From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit.txt: (synopsis): move -i and -o before "--"
Date: Wed, 01 Dec 2010 11:01:56 -0800
Message-ID: <7v4oaxwc4b.fsf@alter.siamese.dyndns.org>
References: <7vlj4b280b.fsf@alter.siamese.dyndns.org>
 <74d884bbd76bf090472b123f8053f095cda523f9.1291215072.git.jari.aalto@cante.net> <20101201163930.GE26120@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jari.aalto@cante.net, git@vger.kernel.org,
	Joey Hess <joey@kitenet.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 20:02:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrwh-0004mr-AI
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338Ab0LATCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:02:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab0LATCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:02:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A591124E9;
	Wed,  1 Dec 2010 14:02:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vmp3ZKp+oIxLqndUfocuk9ABSzc=; b=llKXbJ
	hyTjrPA6dQtgRtCg0m7dsnCLGvreMdFj6e0EsgAXW+Q+hXf98b/7AlLx6dRrGxka
	qoO1NdLQe2jseakbzXSk4juctjABn4OTOImJUo1wyEzpDTzyGBaJUVoOd7qYuO73
	SADMJvjO+dab/pVt/zGRnMGxV1znTBMxN7FsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SvIyLrsqQglPSi5x8hgygsgPO5dZw5vJ
	dNb6Xj5DCTekg/KB2MN3eortVdFoRmQobZT0qWdOfawEn+urwDM58dXZWVTyuoJ5
	XDtqyhAItBuGeZsHM7yVxHjay8M2ZKuTBHbaDFlKWubYM7JTZfzdZBlgK3RauBYE
	9hw7L8srs4I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64B5824E7;
	Wed,  1 Dec 2010 14:02:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08C2C24E6; Wed,  1 Dec 2010
 14:02:16 -0500 (EST)
In-Reply-To: <20101201163930.GE26120@burratino> (Jonathan Nieder's message of
 "Wed\, 1 Dec 2010 10\:39\:30 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8719454A-FD7D-11DF-86C6-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162574>

Jonathan Nieder <jrnieder@gmail.com> writes:

> jari.aalto@cante.net wrote:
>
>> From: Jari Aalto <jari.aalto@cante.net>
>
> "The -i and -o options cannot be used after --, so do not get the reader's
> hopes up by suggesting they can.
>
> Reported-by: Joey Hess <joey@kitenet.net>"
> ...
> While at it, shouldn't we get rid of the extra space after "-o"?

Will do all of these at my end.

Thanks for an excellent coach to other contributors, as always.
