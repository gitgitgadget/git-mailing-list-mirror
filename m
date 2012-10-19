From: <dag@cray.com>
Subject: Re: libgit2 status
Date: Fri, 19 Oct 2012 17:11:58 -0500
Message-ID: <nngobjyf6xd.fsf@transit.us.cray.com>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
	<7vharpv77n.fsf@alter.siamese.dyndns.org>
	<nnglih0jotj.fsf@transit.us.cray.com>
	<7vfw78s1kd.fsf@alter.siamese.dyndns.org>
	<nngsjb8i30w.fsf@transit.us.cray.com>
	<7v6284qfw8.fsf@alter.siamese.dyndns.org>
	<20120827214027.GA511@vidovic> <nngr4qqhp7x.fsf@transit.us.cray.com>
	<7vvcg2zwvq.fsf@alter.siamese.dyndns.org>
	<CACnwZYe6BZVuqCCPho5+3dy=rzKqDv1A8uGAvhLm2JPO9b2LMw@mail.gmail.com>
	<CALkWK0=P7THaJduYFS1Sr6mxtNqAWQsDgwQyr_KEX4NA4kmVSA@mail.gmail.com>
	<7vvce6i5j2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>, <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Andreas Ericsson <ae@op5.se>, <greened@obbligato.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 00:24:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPKzn-0000Ma-Kq
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 00:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab2JSWYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 18:24:36 -0400
Received: from exprod6og107.obsmtp.com ([64.18.1.208]:37483 "EHLO
	exprod6og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab2JSWYf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 18:24:35 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2012 18:24:34 EDT
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob107.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUIHTIsXee6FgXMrxCARwk98lWA5gKOVO@postini.com; Fri, 19 Oct 2012 15:24:34 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Fri, 19 Oct
 2012 17:11:59 -0500
In-Reply-To: <7vvce6i5j2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 19 Oct 2012 13:13:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208073>

Junio C Hamano <gitster@pobox.com> writes:

> I actually hate "include/git.h vs src/git.c"; you have distinction
> between .c and .h already.

+1

                          -David
