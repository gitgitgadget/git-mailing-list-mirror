From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7501-commit.sh: Add test case for fixing author in amend commit.
Date: Mon, 05 Nov 2007 13:23:24 -0800
Message-ID: <7vpryoo08j.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711051020330.4362@racer.site>
	<1194283047-16565-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9QD-0002bk-23
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbXKEVXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 16:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937AbXKEVXd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:23:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57075 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbXKEVXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 16:23:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 094B22F2;
	Mon,  5 Nov 2007 16:23:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5612E9168E;
	Mon,  5 Nov 2007 16:23:49 -0500 (EST)
In-Reply-To: <1194283047-16565-1-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Mon, 5 Nov 2007 12:17:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63556>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> ---
>
> How about this?

Looks Ok; will queue.

Thanks.
