From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Documentation: lost-found is now deprecated.
Date: Thu, 08 Nov 2007 17:34:14 -0800
Message-ID: <7vprykxkvd.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site>
	<7vlk998u6r.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711080041120.4362@racer.site>
	<20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se>
	<20071108160114.GB20988@diku.dk>
	<7vzlxo1mga.fsf@gitster.siamese.dyndns.org>
	<20071109002001.GB5082@diku.dk>
	<7v7iksz00j.fsf_-_@gitster.siamese.dyndns.org>
	<20071109012758.GB5903@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:34:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIle-0003Un-LY
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbXKIBe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756039AbXKIBe1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:34:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50185 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbXKIBe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:34:26 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 228262F2;
	Thu,  8 Nov 2007 20:34:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 94F3893AFE;
	Thu,  8 Nov 2007 20:34:42 -0500 (EST)
In-Reply-To: <20071109012758.GB5903@diku.dk> (Jonas Fonseca's message of "Fri,
	9 Nov 2007 02:27:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64109>

Jonas Fonseca <fonseca@diku.dk> writes:

> Junio C Hamano <gitster@pobox.com> wrote Thu, Nov 08, 2007:
>> This makes it possible to mark commands that are deprecated in the
>> command list of the primary manual page git(7), and uses it to
>> mark "git lost-found" as deprecated.
>
> How about also marking git-tar-tree as deprecated?

Good eyes -- I missed it from my "git grep DEPRECATED Documentation/"
output.

Thanks.
