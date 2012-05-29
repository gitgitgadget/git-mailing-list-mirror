From: jupiter.hce@gmail.com
Subject: 1.7.10.3 configure does not generate Makefiles
Date: Wed, 30 May 2012 09:32:38 +1000
Message-ID: <20120529233238.GC3072@gmail.com>
Reply-To: jupiter.hce@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 13:33:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZh9E-0006A3-FM
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 13:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024Ab2E3Lc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 07:32:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36769 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab2E3Lc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 07:32:58 -0400
Received: by pbbrp8 with SMTP id rp8so7338962pbb.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:reply-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=m80nODRdmxxqymHSWm6F7nUbObicmILLrMPRJzD5WsM=;
        b=0OPcfZ6agbg7GqmHDsUnvwA3J9v+SQYGkg+lywPWTcrtN1KUoJ1EY45J5P48VOlShL
         1yOT9HcBC2DRgypA32J0/C0qrCemtMw9ToMGdc0nYU/7o28JYcAZ9NEUUXEjPTi6njNX
         MvhxIQa9GONupLgeqj1vqgILL2LolJ7fMlsA0TgSP7USN4c5a8hl7BoMJ8JYtp/+ntfJ
         ih3AjCkIvj9bbtuztAhT1Iw8PNwqkTq0LgpppJMnEwteEcI13XpzyLyoOPAx/M6E9ZP0
         n5AW1511eWYUerCiOK5Him8toGC25yqvqojGc7GrhPHRrRcvfMuu3BsBzMrwKtC+Kn2M
         G1PQ==
Received: by 10.68.134.1 with SMTP id pg1mr10923139pbb.1.1338377578052;
        Wed, 30 May 2012 04:32:58 -0700 (PDT)
Received: from debian ([210.56.91.129])
        by mx.google.com with ESMTPS id rv8sm211482pbc.64.2012.05.30.04.32.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 May 2012 04:32:57 -0700 (PDT)
Received: by debian (Postfix, from userid 1000)
	id 7FCCB411D2; Wed, 30 May 2012 09:32:38 +1000 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198802>

Hi,

I've just downloaded 1.7.10.3 source tarball and following the
instruction from INSTALL, I ran the autoconf to generate the
configure, then to run configure --prefix=/usr/local/git/1.7.10.3.
There were no errors but there was no Makefiles generated either. How
can I run the configure to generate Makefiles?

.......
configure: creating ./config.status
config.status: creating config.mak.autogen

Thank you.

Kind regards,

hce
