From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] Explicit error when curl_exec() fails
Date: Thu, 14 Jun 2012 14:45:54 +0200
Message-ID: <vpq7gvaawot.fsf@bauges.imag.fr>
References: <1339607025-22725-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	<1339664243-31952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1339664243-31952-4-git-send-email-Matthieu.Moy@imag.fr>
	<4FD9AD9F.5050708@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr, Charles.Roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr
To: Simon.Cathebras@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Thu Jun 14 14:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf9R9-0001Mz-SI
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 14:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab2FNMqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 08:46:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52092 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985Ab2FNMqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 08:46:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5ECjspe007559
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 14:45:54 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sf9Qx-0003fM-A4; Thu, 14 Jun 2012 14:45:55 +0200
In-Reply-To: <4FD9AD9F.5050708@ensimag.imag.fr> (Simon Cathebras's message of
	"Thu, 14 Jun 2012 11:23:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 14 Jun 2012 14:45:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5ECjspe007559
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340282758.43563@Le5ReVJDxl4DkRMAr7S1Pw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200004>

"Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> writes:

> But there is a whitespace/indentation problem isn't it ?

Yes: your code is indented with spaces.

(my code has an extra space between die and "(" that said)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
