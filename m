From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: Re: [StGit] Emacs mode merge request
Date: Wed, 9 Jun 2010 17:30:01 +0200
Message-ID: <AANLkTik7p3H9xHbZz80-Zn6nXWy0txfe-ShJNlD241cH@mail.gmail.com>
References: <AANLkTiklRA-d8p3NhpvjZLua0zE7uK8RFrJTegCr-Jjd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 17:30:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMNES-0006mR-31
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 17:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270Ab0FIPaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 11:30:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39887 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757214Ab0FIPaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 11:30:04 -0400
Received: by bwz11 with SMTP id 11so1592831bwz.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=6WVBeWhIAI2U+NruPpm9vP0mIFUF3nA+tfkfi+LeIhg=;
        b=H6JL3vihI5jfeiWS6SO4Vhj9vU49r+SWT3XUP5Ai9Y/LbfVufdXEcWCWmVYgKq7fhD
         WoYzU0SpnpwccQ+Uepb4yKfhWKwaOec62lFTL7IeD0pSKPBHLLWf0p/s12NAVJcIEM7w
         BcZy0MtSKDBCQlQuxdNCuvYZJxt2TQ7Lx31/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=OUUuBv0ppQ7yOIFXAfotH8egNI1MQy9hUZBpkhZ/PZYWYyCLW9Im12UGNFg3eXSK3W
         4ujctv4ynnnAl2Dw49FPfnZqDJkcOeIgXtOlH4h/DcK1QpvBAcZ01tJeaAWPE9DHGsIE
         m6b3vGnZnqsrUvsjlsx79o+42wjAm4RSAKrMY=
Received: by 10.204.160.134 with SMTP id n6mr1254031bkx.0.1276097401067; Wed, 
	09 Jun 2010 08:30:01 -0700 (PDT)
Received: by 10.204.53.206 with HTTP; Wed, 9 Jun 2010 08:30:01 -0700 (PDT)
In-Reply-To: <AANLkTiklRA-d8p3NhpvjZLua0zE7uK8RFrJTegCr-Jjd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148787>

Turns out I forgot to push those changes; they've been pushed now.

- Gustav
