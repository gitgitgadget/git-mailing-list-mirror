From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Documentation: explain "git branch --with"
Date: Tue, 7 Sep 2010 10:51:22 +0000
Message-ID: <AANLkTin9j9LEF=zaZnso+0E0S_eTy1q6FM5d1h0q92jq@mail.gmail.com>
References: <4C83FEC3.3040101@gmail.com>
	<7viq2jv05c.fsf@alter.siamese.dyndns.org>
	<AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com>
	<AANLkTim4kxpQj_UFOBcwCaVmBFCHun4T9t3O9Zvq3w49@mail.gmail.com>
	<AANLkTinPDUeL2jaY3P17TiA959WH8eOQZ4=CeaHOYuq2@mail.gmail.com>
	<7v39tmtpci.fsf@alter.siamese.dyndns.org>
	<20100907055209.GT1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 12:51:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osvlx-0003c3-Ay
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 12:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab0IGKvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 06:51:25 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36198 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab0IGKvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 06:51:23 -0400
Received: by gwj17 with SMTP id 17so1838075gwj.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=2UPniYhjtRH1edZHKl3Vg1Ui8IpR4icBckmE3I+h/sY=;
        b=K0ieHIHpq0In9WPv7OM9yRlj9YmcyytePds6jI2R46CvtsUGabMTmLs1YDlOPNAsrv
         ec51jHfPr4jxtYG+xoonrBUphl4pIdY8WadJGg5FBqUR3BaMjkcs2UItDE6qa82eK9mN
         0fc2qAqd2wDuTVYhRdBV/Xfhsb7J2QQcgz6Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NAkS3F8oG/V54mAQuvbpaJXndtDalFcGJQ19BcacEs9IXM1PXOBWTXW7Floa6vVnA2
         NkgmM49INU0zrlISnWYxNhaKNiJZ1plxWkqPjsmYyrvlL8aIOMfFr+NWmyZ3pUt0qqlc
         yQ4//qo1WyqVrw3lVTeB6jZRoU+/R0ItOEyCk=
Received: by 10.90.73.10 with SMTP id v10mr840027aga.94.1283856682502; Tue, 07
 Sep 2010 03:51:22 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 7 Sep 2010 03:51:22 -0700 (PDT)
In-Reply-To: <20100907055209.GT1182@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155693>

On Tue, Sep 7, 2010 at 05:52, Jonathan Nieder <jrnieder@gmail.com> wrote:
> How about adding it to the man page so people can look up this option
> after encountering it in the wild?

Much better, thanks.
