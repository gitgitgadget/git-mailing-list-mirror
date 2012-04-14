From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] completion: improve 'git --exec-path' completion
Date: Sat, 14 Apr 2012 09:21:52 +0200
Message-ID: <m2aa2eeq27.fsf@linux-m68k.org>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
	<1334274603-3277-5-git-send-email-felipe.contreras@gmail.com>
	<20120413060845.GA15610@burratino> <20120413180436.GA2387@burratino>
	<20120413183048.GB2387@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 09:22:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIxJc-0003rq-Pi
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 09:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab2DNHV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 03:21:56 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33895 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab2DNHV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 03:21:56 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VV6jj0zmDz3hhXK;
	Sat, 14 Apr 2012 09:21:45 +0200 (CEST)
Received: from linux.local (ppp-93-104-151-58.dynamic.mnet-online.de [93.104.151.58])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VV6jj2x0hz4KK6d;
	Sat, 14 Apr 2012 09:21:45 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 2FEC91E52D6; Sat, 14 Apr 2012 09:21:53 +0200 (CEST)
X-Yow: Has everybody got HALVAH spread all over their ANKLES??...
 Now, it's time to ``HAVE A NAGEELA''!!
In-Reply-To: <20120413183048.GB2387@burratino> (Jonathan Nieder's message of
	"Fri, 13 Apr 2012 13:30:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195471>

Jonathan Nieder <jrnieder@gmail.com> writes:

> --exec-path looks like to the completion script like an unambiguous

s/like (.*like)/\1/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
