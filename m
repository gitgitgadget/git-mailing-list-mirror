From: Ivan Kanis <expire-by-2010-08-14@kanis.fr>
Subject: Re: Git server eats all memory
Date: Mon, 09 Aug 2010 19:38:06 +0200
Message-ID: <871va7lm9t.fsf@kanis.fr>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	<87hbj74pve.fsf@kanis.fr>
	<AANLkTi=yeTh2tKn9t_=iZbdB5VLrfCPZ2_fBpYdf9wta@mail.gmail.com>
	<wesbp9cnnag.fsf@kanis.fr>
	<AANLkTinT-taMqB87moLZ_CLio2USnxsriq6U0EJvSGte@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 19:38:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiWIm-0005Ck-HT
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 19:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab0HIRiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 13:38:12 -0400
Received: from kanis.fr ([75.127.73.245]:4538 "EHLO kanis.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab0HIRiM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 13:38:12 -0400
Received: from [89.83.137.164] (helo=tao)
	by kanis.fr with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <expire-by-2010-08-14@kanis.fr>)
	id 1OiWIb-00052T-Ft; Mon, 09 Aug 2010 13:38:09 -0400
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
In-Reply-To: <AANLkTinT-taMqB87moLZ_CLio2USnxsriq6U0EJvSGte@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Mon, 9 Aug 2010 19:57:00 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152991>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> This command on git already gives me ~40MB peak. Are you sure you ran
> it on your big repo?

Hi Nguyen,

Yes I ran it on the big repo...

Take care,
-- 
Ivan Kanis
http://kanis.fr

Men of lofty genius when they are doing the least work are the most
active.
    -- Leonardo da Vinci 
