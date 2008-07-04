From: "Neshama Parhoti" <pneshama@gmail.com>
Subject: Re: git push requires a subsequent git reset --hard ?
Date: Fri, 4 Jul 2008 16:25:57 +0300
Message-ID: <912ec82a0807040625h3d4518bo270089cb5995aec6@mail.gmail.com>
References: <912ec82a0807010951j9e970f2k9624682b33c8af7d@mail.gmail.com>
	 <m3vdzpfr16.fsf@localhost.localdomain>
	 <20080702133606.GP5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>, peff@peff.net
X-From: git-owner@vger.kernel.org Fri Jul 04 15:27:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KElJS-0007ix-44
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 15:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbYGDN0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbYGDN0A
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:26:00 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:48003 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbYGDNZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:25:59 -0400
Received: by an-out-0708.google.com with SMTP id d40so243922and.103
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=seThuvYhOaJuUra2dsKGQUEbducYJkiryxpoSPQ9qLY=;
        b=iMRaTi64pMRingkt7M3mnxaUXk++gy7b8WDPA0IYWfq6l++WDqQFlEeE/ZZZVrnvWP
         Lo0KmoA7ZeGsp/O68gNmHQ7kUUZ3lhbaNgBhYl1w10wMF6eWUkqDPEqVOeIgcCw1RjzH
         OBP2/ILwPBvRrCbUXA/4Ew6qr9xwYjxPKqKtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZFsVS3u46Cf44WvnBJXfCwZ58iAnjhGAJxmYvgcUDCf9q/JwUsbHqPOGMXhReMWwlS
         SxYepJ0f0Hb9J8ixL3EIcl8PcWh6dmNEDpCvtl9bs2i+E7XygbSFt49962IVFgJVsO84
         4vH/fxqTnxYl3S0oq8mf2JUTulTycyZnRfJNg=
Received: by 10.100.191.19 with SMTP id o19mr729749anf.73.1215177957925;
        Fri, 04 Jul 2008 06:25:57 -0700 (PDT)
Received: by 10.100.134.20 with HTTP; Fri, 4 Jul 2008 06:25:57 -0700 (PDT)
In-Reply-To: <20080702133606.GP5737@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87386>

Thank you all for the replies !

I think git has one of the most supportive and friendly community !
