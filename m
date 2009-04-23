From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: svn cp (local paths) equivalent
Date: Thu, 23 Apr 2009 16:03:32 +1000
Message-ID: <CDE4E2DB-9017-4BDD-869C-E470FFDA9CAC@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 08:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lws46-0001mV-3c
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 08:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZDWGDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 02:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbZDWGDk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 02:03:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:18988 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbZDWGDj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 02:03:39 -0400
Received: by wf-out-1314.google.com with SMTP id 26so319975wfd.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=3HXgeSv7BwhgcUohnbMxTtIoXpCcHjIg2PwN+5DUPLA=;
        b=sdgdTsxlpBGjstIQzBbvSjMlbrI8ti2b0AUPw7RtBaFKOMUY4jCr5RS9vrdtGVsH63
         4691dGVJNxoIY6iuR0UFqzxG9NJ9b7IZdJcgADbrosL+aMdSuBL2OHLg7rmdaIcnSoLP
         djJD7EwJ1tx4aBE0r8B9c+8KRGyWwe4IfjCHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=Gom6pZGny7T6nDxRWV1KPGIMD774YH35V7q/3OqmoggfdlY83SItvdmBJGVVrXx3kA
         jRXRqzbgHOUncDUQNZOa3X/fRFVcudeAIybXeeMgeCaOmo5xdgFhEZVjFwYKN28/BSRI
         C4D7er/lWz19tiSRP2BRT585HQfPQ9ZoTR/C4=
Received: by 10.142.212.21 with SMTP id k21mr227340wfg.21.1240466618839;
        Wed, 22 Apr 2009 23:03:38 -0700 (PDT)
Received: from ?10.0.1.200? (208.198.233.220.exetel.com.au [220.233.198.208])
        by mx.google.com with ESMTPS id 22sm2253626wfg.23.2009.04.22.23.03.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 23:03:37 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117300>

Hi there,

just a quick question: in svn you can cp a file or dir within your  
checkout. Is there an equivalent in git?
Thanks.

with regards,
--

Lachlan Deck
