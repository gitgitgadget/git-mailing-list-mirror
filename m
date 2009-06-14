From: Phlip <phlip2005@gmail.com>
Subject: fuggedabadit
Date: Sat, 13 Jun 2009 21:51:25 -0700
Message-ID: <4A3481CD.7050602@gmail.com>
References: <S1750942AbZFNEso/20090614044844Z+270@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 06:53:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFhiG-0002Kq-B8
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 06:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbZFNEv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 00:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbZFNEv1
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 00:51:27 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:48027 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZFNEv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 00:51:26 -0400
Received: by pzk17 with SMTP id 17so1321732pzk.33
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 21:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Ckb1d4PnTN7K+OO9npzbFJAkxXwqcRxz3nVBTQCYmY4=;
        b=IU88lAg97E0tCZUn1OLb8YzD9YvEdXYqHWKJ5Bd+s2SKvd8XCeFPFxfil523AN0yM5
         zEKxNOldAh02O/sXjQ4oWj46UJAlGcTIxAF7OytcrIwFPUUJHZCWH3bNeTcWQ5Y9fYsx
         jy+7EZYuc+Y442JLS6J0qU8phZvBhdvWZcwzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=qFYSCq+q0UGHH0MmKCwWY+49TeM7SYN2uIitKlyCCckIyihb3RlOndr3tcxZZk894f
         iFk/GczYXXggFnVpASvtA0wSNnAygjvxEYHYzr6IqA0Qb02YARAQkt9bzlVmjCR21OTX
         mP0u9LineOe37v+Ayg7HZbe+5JPsxe1Mhyib4=
Received: by 10.142.213.5 with SMTP id l5mr2170506wfg.189.1244955088223;
        Sat, 13 Jun 2009 21:51:28 -0700 (PDT)
Received: from ?192.168.1.108? (adsl-76-212-161-118.dsl.sndg02.sbcglobal.net [76.212.161.118])
        by mx.google.com with ESMTPS id 24sm2747024wff.11.2009.06.13.21.51.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 21:51:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <S1750942AbZFNEso/20090614044844Z+270@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121534>

Gitsters:

El Goog has the wrong answer for the question "how do I forget about a file?" 
Someone cheerfully directed me to git rm, as equivalent to svn rm.

I don't need the actual file to go away. (I, uh, mumble, checked in too much 
when starting out, and now git commit is slooow.)

How do I tell git to forget about a file, but leave on my hard drive?

-- 
   Phlip
   (BTW, the 1980s called - they want their mailing list software back!;)
