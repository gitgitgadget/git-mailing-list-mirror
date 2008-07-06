From: Ittay Dror <ittay.dror@gmail.com>
Subject: something like 'find' in revisions
Date: Sun, 06 Jul 2008 14:05:36 +0300
Message-ID: <4870A700.8040205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 13:07:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFS5S-0005Is-VA
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 13:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbYGFLGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 07:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYGFLGZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 07:06:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:24342 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYGFLGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 07:06:24 -0400
Received: by nf-out-0910.google.com with SMTP id d3so529123nfc.21
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 04:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=nyrgW0uLBsFbBXkxx7AhEBiCMu2m4kzT7VMd6Quu6Q0=;
        b=ZAXwCW9Vsc5RLoea7CHl6UmfQu1bpFgeNnwIDSzk1aBRVzqPa1DHncxh6krnoUf7AP
         XQzFEBWkufN/5ri7mFa+KJtuyOQeFWbbSkWcAVqaLgMlet33QklWYEQnOp+w4xKYUSDn
         qIWrzeXjOwnNwajWhdE7ksFjLpPDrUAwXd0hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=Xkt6nuYIAhz3nW0ghAUP7efTr70A0I4BE+0oLeGnzlDm+uPSKWDksoBJtCUKMZSXqL
         ZuasAfCYWT1yYHUCpHs78u3hcZX8k5xlmbmMF+5ymVBli5ibG1Dsnr2Y2BjaVE/YxDEF
         R8BgI7gX+rkKwd0ypEmtZBcrlVsGLjQxHwovg=
Received: by 10.103.217.7 with SMTP id u7mr1459003muq.24.1215342380336;
        Sun, 06 Jul 2008 04:06:20 -0700 (PDT)
Received: from ?10.10.2.7? ( [212.143.191.180])
        by mx.google.com with ESMTPS id s10sm3735875mue.16.2008.07.06.04.06.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 04:06:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87514>

Hi,

How can I find files with a given name (or pattern) in my history (where 
I don't know the exact path and some files have been removed)?

Thank you,
Ittay

-- 
--
Ittay Dror <ittay.dror@gmail.com>
