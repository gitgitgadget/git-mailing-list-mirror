From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 01/10] refs: add "for_each_bisect_ref" function
Date: Thu, 26 Mar 2009 07:20:25 +0100
Message-ID: <fabb9a1e0903252320j2edf4a8ct39f784c4319c3cb0@mail.gmail.com>
References: <20090326055509.1bc16b28.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 07:25:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmj2D-0003z1-99
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 07:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbZCZGUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 02:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbZCZGUo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 02:20:44 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47523 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZCZGUn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 02:20:43 -0400
Received: by fxm2 with SMTP id 2so380530fxm.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=smJfixdr67gy8Xw5ztfOjZ8x0I7ycTmPmYJnGojbWpY=;
        b=fZei3HfDLQmcqKYHLWnu2lMyl09IrwBrAAKH9VQQ/Y4DbQU2rs6mh/MItecb0V5dWU
         a/vFNhBQ4L4Btdb2/JC4aM1BQ4WoywqN8LOEcVbPVr/33lVb+4vObs4kwO8wD2KRpfdF
         Yib6IEfJD7BZSpIeNob1bW8zTp5KY4muyE/GU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ELrg6eWQFiTW2AN7AZEKHa+D49UtDActmQU+TYMZqzbuwAFgGPYmicYVTTb65kKPe8
         fO6Bf6bVGZGM2uVVl66D7v/n2iPCev/kjrSTF+4ATyHSo2ovBvYT+lOXKnzHU6QrPNTf
         5teAiTHUdAaKJff2PtMiOukcG57SQaS5TcrTk=
In-Reply-To: <20090326055509.1bc16b28.chriscool@tuxfamily.org>
Received: by 10.103.241.5 with SMTP id t5mr203537mur.127.1238048440313; Wed, 
	25 Mar 2009 23:20:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114737>

Heya

On Thu, Mar 26, 2009 at 05:55, Christian Couder <chriscool@tuxfamily.org> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

A 10 patches series with no cover letter? And no description of the
individual patches either! C'mon Christian, you know better than that
;).

-- 
Cheers,

Sverre Rabbelier
