From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/3] archive: add shortcuts for --format and --prefix
Date: Thu, 9 Apr 2009 20:38:55 +1000
Message-ID: <fcaeb9bf0904090338y6295f459odd25628c1ceac93a@mail.gmail.com>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com> 
	<1239260490-6318-2-git-send-email-pclouds@gmail.com> <7v8wma43ii.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 12:41:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrrhL-0006qN-Tw
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 12:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933994AbZDIKjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 06:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934002AbZDIKjN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 06:39:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:8382 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933980AbZDIKjL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 06:39:11 -0400
Received: by rv-out-0506.google.com with SMTP id b25so198616rvf.5
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=O+X0sMwVC14FKcIDW0pG30tbilYj8GmT0i2eml31rMY=;
        b=Naq06UnQGX7pFplc3OqSVPObUPmx4qIIcNELwJv4FrQmInpu/GsfL71u3LezxR319/
         dMsJoC2b35iVL/t7MzpeoVu1a6id4W/XgbqFSl0zEKRyVwpcJvStTFh3wowe2sf5NXr+
         jG9FdTPCTtzL0JjWtc6a/09NjgOLMAlZHcj+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SF2cJ+DlxE8a0tNkjr57kl/+fG6+4IJG5xhi6ZrFd7nyV2m5DXsqV0oeCTPIbStIIH
         tiJOrDFv723bac4F11bpXGzDnfoVh/b4ENklKQmIu2abFYRojJtxC4/zyeDAo+GXNwXP
         MxpAzGLwf2WdGNBuQHZV8Tm8P0cVlNenKnSI4=
Received: by 10.142.51.4 with SMTP id y4mr843137wfy.39.1239273550382; Thu, 09 
	Apr 2009 03:39:10 -0700 (PDT)
In-Reply-To: <7v8wma43ii.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116160>

2009/4/9 Junio C Hamano <gitster@pobox.com>:
> Is this really necessary?

I have used a lot it to test and typing --format=blah is just painful.
As I said earlier, this is just a convenient patch (at least for me).
Feel free to drop it if it causes confusion.
-- 
Duy
