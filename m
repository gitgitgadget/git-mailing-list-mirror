From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] builtin-push: New long option --verbose
Date: Mon, 27 Aug 2007 10:51:20 +0200
Message-ID: <878x7xjr7b.fsf@morpheus.local>
References: <y7fxeal4.fsf@cante.net> <7vtzqll7hf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 10:52:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPaKg-0003CU-En
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbXH0IwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Aug 2007 04:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbXH0IwW
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:52:22 -0400
Received: from main.gmane.org ([80.91.229.2]:51549 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbXH0IwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:52:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPaKA-0008SG-58
	for git@vger.kernel.org; Mon, 27 Aug 2007 10:51:54 +0200
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 10:51:54 +0200
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 10:51:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:sm2YR384wQkCDIRfOuGtYc/sfWg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56790>

Junio C Hamano <gitster@pobox.com> writes:

> Why?

One reason is that I often don't know if the program I want to run
(git or something sles) uses -v as the "verbose" flag, or if it's the
"version" flag or something else.  But if there is a --verbose flag, I
can be sure what it is, so I often try that first if I'm unsure.  If
that faild, I'll probably look in the man page.

--=20
David K=C3=A5gedal
