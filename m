From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 9/9] gitweb: add alt text to avatar img
Date: Sun, 28 Jun 2009 18:10:25 +0200
Message-ID: <cb7bb73a0906280910n22c5907av910b1de28a6c2f2b@mail.gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-9-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-10-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906281743.55871.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 18:17:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKx3z-00005p-H9
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 18:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbZF1QQ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Jun 2009 12:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbZF1QQ5
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 12:16:57 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58856 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbZF1QQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jun 2009 12:16:56 -0400
Received: by fxm18 with SMTP id 18so549251fxm.37
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7rzOr53NduW5Crrfd0eSMuhWTZVPWokjEKhbsuxLS+4=;
        b=O3W/88s1vfI70HFUDeeMXviJWIEIk+6YwkycljqiE8AWwA452GFWYEOX5Mc0+IGpIU
         C23VwPrAyJMwuzffrnPy1aZxHi3SygowUQoYrvRPfD6+p7ijKT2L8xCSBqflKrBVOrFP
         LZTJYBKS9rXnVcO6A/5Hmq53eUdrnHnW/6U/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RaNmKq9m7l5TA2BIHlQIDNJXQ1ZQjYYEmw9qTYVcGlQoURMr2GzZ4BSJWA8+5N9AIQ
         Pj1teYpD9eM2GWWq+Y0+iWtI/XDaTmx2lJ4POnKvAAd5lX6+T0jx5I+TnYV5j+8zUssQ
         GHfyMomMMl7jrfykI1qcljmFqsNeuuIBhaswU=
Received: by 10.204.65.1 with SMTP id g1mr6131642bki.57.1246205425767; Sun, 28 
	Jun 2009 09:10:25 -0700 (PDT)
In-Reply-To: <200906281743.55871.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122413>

2009/6/28 Jakub Narebski <jnareb@gmail.com>:
> Signoff?

Duh.

> Bit of bikeshedding: "alt=3D\"\" " (empty alt text) would also be
> a good solution. =A0This way text browser which do not display images
> wouldn't take limited horizontal space for alt text of extraneous
> avatar image.

Oh, interesting. Let me try that.

--=20
Giuseppe "Oblomov" Bilotta
