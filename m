From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] build: add default aliases
Date: Wed, 25 Sep 2013 17:13:07 +0200
Message-ID: <vpqk3i5szng.fsf@anie.imag.fr>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
	<CAMP44s3nQv97B2=mq-mn8S41sMA43qRfr+nC7eQ=Jft=zRgTRw@mail.gmail.com>
	<CAEBDL5V1kyRwtKSM+L_E_XbJRauvdmOLc+g2acbixt0+pd6_ag@mail.gmail.com>
	<CAMP44s2j_ra_Tk_s-tjwwvX=T8y=bKPTaUdOQk1jD8QpUm+-zA@mail.gmail.com>
	<CAEBDL5X1QRLaTvxhEu4e5_NE5fEWc6fd60YJyA8wye4d4T3wpQ@mail.gmail.com>
	<CAMP44s2EtgXXdfa+QtUmmRh6wZ1fD8YTWtzLJ2mN6y_6faMM_g@mail.gmail.com>
	<vpqr4cdt0gk.fsf@anie.imag.fr>
	<CAMP44s3qv==GZt7BYMc-FuQvVoNGf3kkGAGzk=-=F4A8KZojKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 17:13:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOqmC-0000Wb-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 17:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097Ab3IYPNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 11:13:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46213 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756093Ab3IYPNM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 11:13:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8PFD61c003296
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Sep 2013 17:13:06 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VOqm4-0000Z3-2u; Wed, 25 Sep 2013 17:13:08 +0200
In-Reply-To: <CAMP44s3qv==GZt7BYMc-FuQvVoNGf3kkGAGzk=-=F4A8KZojKQ@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 25 Sep 2013 10:08:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Sep 2013 17:13:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8PFD61c003296
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380726787.40317@kItn35V9r8fZX7P67G5Rzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235353>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Sep 25, 2013 at 9:55 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> But let me help you; you can't mention one, because there isn't any.
>>
>> Or because you didn't really look. Read the release notes of every Git
>> release these days, there's a big section about ongoing backward
>> incompatible changes.
>
> I said *important* changes from the common user's point of view.

Call me fool, but I do consider the default behavior of "git push" as
something important, indeed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
