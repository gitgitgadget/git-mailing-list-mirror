From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/9] stash: add --stage option to save
Date: Thu, 29 Aug 2013 20:39:41 +0200
Message-ID: <vpq4na8s5n6.fsf@anie.imag.fr>
References: <20130829180129.GA4880@nysa>
	<1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
	<1377800080-5309-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:39:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF78R-0001kK-4P
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532Ab3H2Sjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:39:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56727 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755399Ab3H2Sjx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:39:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TIdeFN010871
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 20:39:40 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF78A-00031s-4h; Thu, 29 Aug 2013 20:39:42 +0200
In-Reply-To: <1377800080-5309-5-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 29 Aug 2013 13:14:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 20:39:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TIdeFN010871
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378406384.99641@3/ume3pbIRkv/bapCCLhUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233330>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +index are left intact. Same with `--no-stage`, which is a snynonym.

s/snynonym/synonym/

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
