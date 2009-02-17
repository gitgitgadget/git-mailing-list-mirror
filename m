From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bash: add missing 'git merge' options
Date: Mon, 16 Feb 2009 18:24:12 -0800
Message-ID: <7vmyclby2b.fsf@gitster.siamese.dyndns.org>
References: <7v7i3sp8jk.fsf@gitster.siamese.dyndns.org>
 <1234704311-14774-1-git-send-email-szeder@ira.uka.de>
 <20090216155646.GB18525@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 03:26:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZFej-0004EZ-Uv
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 03:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbZBQCYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 21:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbZBQCYV
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:24:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbZBQCYU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 21:24:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 385879A020;
	Mon, 16 Feb 2009 21:24:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E9F279A01D; Mon,
 16 Feb 2009 21:24:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 149D4B82-FC9A-11DD-B80F-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110293>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> wrote:
>> Namely: '--commit', '--stat', '--no-squash', '--ff', '--no-ff'.
>>=20
>> One might wonder why add options that specify the default behaviour
>> anyway (e.g. '--commit', '--no-squash', etc.).  Users can override t=
he
>> default with config options (e.g. 'branch.<name>.mergeoptions',
>> 'merge.log'), but sometimes might still need the default behaviour.
>>=20
>> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>> ---
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks, both.
