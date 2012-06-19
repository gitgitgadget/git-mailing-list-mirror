From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] sync German translation of git-gui with git-core
Date: Tue, 19 Jun 2012 15:27:03 -0700
Message-ID: <7vk3z3x7ig.fsf@alter.siamese.dyndns.org>
References: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
 <87pq8v2c6a.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, stimming@tuhh.de,
	trast@student.ethz.ch, jk@jk.gs, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 00:27:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6tD-0004Kz-05
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 00:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab2FSW1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 18:27:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517Ab2FSW1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2012 18:27:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD8E994D2;
	Tue, 19 Jun 2012 18:27:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X4HxZEjzTneT
	0GLfhwR5LyPcRDY=; b=XuRc5uzZ44Kxx4r/kbRz424CxHGKlor586YTscYSugDU
	9uwap/U+qDzHIp9+UW5QZYuVPJ96LmwhAeBjuCfWbUQRoMESMcpwK7pL0/28d1Kr
	y1tRHXBC7c+8migUJ4zmEbnhhvBpiHohxdBxfRmH2y12oUOIBaqGQwSBP8QfUKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sHFoci
	RHVQ1EW3ayU4j6PGSjRjrbhrPeGA6b6Iy98j7FY24dA5qWpqls1Lzi4wC3dnQboW
	Cy/kQOJvWBNVhez2omj+yX9GyIyPjTCLH1AqkbZLrIN8qXZpaxChMoXPPL+ntYLv
	sLI2TicQgX0r+Rvc5/fft5hBYTLXlSbC4+c+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C46D894D1;
	Tue, 19 Jun 2012 18:27:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BD1794D0; Tue, 19 Jun 2012
 18:27:04 -0400 (EDT)
In-Reply-To: <87pq8v2c6a.fsf@fox.patthoyts.tk> (Pat Thoyts's message of "Tue,
 19 Jun 2012 23:02:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E58E8628-BA5D-11E1-B624-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200261>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Ralf Thielow <ralf.thielow@googlemail.com> writes:
>
>>We should keep the translation of the tools in sync with
>>git-core. So this patch series sync the German translation
>>of git-gui with the git-core one.
>>
>>Ralf Thielow (3):
>>  git-gui: de.po: consistently add untranslated hook names within
>>    braces
>>  git-gui: de.po: translate "bare" as "blo=C3=9F"
>>  git-gui: de.po: translate "remote" as "extern"
>>
>> po/de.po | 36 ++++++++++++++++++------------------
>> 1 Datei ge=C3=A4ndert, 18 Zeilen hinzugef=C3=BCgt(+), 18 Zeilen entf=
ernt(-)
>
> Thank you for this -- applied and pushed.

Please make sure to throw a pull-request at me when appropriate.

Thanks.
