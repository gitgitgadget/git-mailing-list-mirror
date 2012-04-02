From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Mon, 02 Apr 2012 22:40:35 +0200
Message-ID: <vpqiphhdfzw.fsf@bauges.imag.fr>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<7vlimegjw9.fsf@alter.siamese.dyndns.org>
	<vpqy5qejbjl.fsf@bauges.imag.fr>
	<7vobraf057.fsf@alter.siamese.dyndns.org>
	<vpqwr5ydkqt.fsf@bauges.imag.fr>
	<7vzkatex02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 22:41:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEo3f-0004t6-Es
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 22:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab2DBUkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 16:40:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41454 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520Ab2DBUky (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 16:40:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q32KZBAs031314
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Apr 2012 22:35:11 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SEo3I-0006ac-0m; Mon, 02 Apr 2012 22:40:36 +0200
In-Reply-To: <7vzkatex02.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 02 Apr 2012 12:47:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Apr 2012 22:35:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q32KZBAs031314
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334003714.1171@c6gFN49TC6kz0YupmEikPA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194557>

Junio C Hamano <gitster@pobox.com> writes:

> No more words from me on this subthread.

It's a pity. I still have no answer to my question:

| But why doesn't the same applies to "git pull"? Why would it be natural
| for "git pull" to pull from a branch other than the one with the same
| name?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
