From: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
Subject: Fwd: Bug in StackedGit
Date: Tue, 15 Apr 2008 10:06:43 +0000
Message-ID: <6efe08af0804150306x1075970cxd6c9bed3dd0a6394@mail.gmail.com>
References: <6efe08af0804150301t9f4a1dbte564902736ebc302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 12:09:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jli4o-0002jV-SK
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 12:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbYDOKHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 06:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755556AbYDOKHB
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 06:07:01 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:32887 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549AbYDOKHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 06:07:00 -0400
Received: by yw-out-2324.google.com with SMTP id 5so919983ywb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FuKjporQcmG098QoMiehGOi9odQo8/QM1cd6HTyGOrI=;
        b=QNryZ7cfzA2/EVz2VMDg+F1gpq2yCjcwtShIRAA87r9XemEOEnSHyQnw4ZWQR4rJJh2x9Dydswk/bd+fRP/4N25I9NTKE+eYsGanbr0VOPOMbtFsS7gRr3gTiBFoDOpgvC4NctyfYOd1Yr0WyIzyCjeMlSa/RVS5wapWFL4ARFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JzNWxyT9nuaoo6d3AiCfUIn/JEiTwoPSbpQLkFts921DSZSJyDzErrPsZbXUke24XMz2xkdAqK+9C2NcKiTvqiYEEfJbPHgynJ2OuInpeDbTL6c9rA7nGsIATlUis1F++gqrNF6FdPZLFdhc4kxwWgPcD35rhOgYw/0gmAuvj5Y=
Received: by 10.150.215.16 with SMTP id n16mr7474304ybg.104.1208254003770;
        Tue, 15 Apr 2008 03:06:43 -0700 (PDT)
Received: by 10.150.229.1 with HTTP; Tue, 15 Apr 2008 03:06:43 -0700 (PDT)
In-Reply-To: <6efe08af0804150301t9f4a1dbte564902736ebc302@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79580>

after stg commit all patch history is loss. It's sucks. there are
nothing lost in bzr loom .

\\wbr Vitaly Chernookiy
