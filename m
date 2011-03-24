From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: [PATCH] Clarify workaround for using positional parameters with aliases
Date: Thu, 24 Mar 2011 15:15:07 +0100
Message-ID: <AANLkTi=jZFKax-Z3nzjy4kbbRQPekOxSiR=f0R-n5aCC@mail.gmail.com>
References: <1300802259-31146-1-git-send-email-lasse.makholm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 15:19:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2lNk-0005GW-0w
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 15:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab1CXOTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 10:19:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65286 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1CXOTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 10:19:18 -0400
Received: by bwz15 with SMTP id 15so84982bwz.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=95gsdXSWG/V34OL/eto8UOn5ANGE+lHNPjvxwoXom78=;
        b=rb/kdOkJXzBmYiewIAaZDPRb+di8QjsGtP7mRMAliDSsA3nJ40wQBQhuhI+Fy+GDgL
         m40+gF02YdFfaFRfWOGTVJP0qEmTIOLCUr6rVbQvgqx3ojqEs74iu62auvk6sUritaeo
         8W4qB9sg2gjaTAVhuzlOXdoTLgGpLuuzw/QfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=HF/Ygkqws5GEDNZxWv9B1dUYHeo/ld7nqJaBZXozBrLcy8hbhNs7wXTzBJL16uZIgX
         wTn0vUuCyWd0CAOzIkDDYHwxYI9Tyle8qUybJL3lqTPoVaVeIlR0AtoazrrtF99LcvaU
         2skt8UMVcyMrO1kwyUHAVOn1lOKfVAvrl3jn8=
Received: by 10.204.80.29 with SMTP id r29mr7450885bkk.195.1300976107068; Thu,
 24 Mar 2011 07:15:07 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Thu, 24 Mar 2011 07:15:07 -0700 (PDT)
In-Reply-To: <1300802259-31146-1-git-send-email-lasse.makholm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169916>

> On 22 March 2011 14:57,  <lasse.makholm@gmail.com> wrote:

Oops! Please ignore and see other version. I think this was stuck in
my mail queue... :-)

-- 
/Lasse
