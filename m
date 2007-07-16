From: "Aubrey Li" <aubreylee@gmail.com>
Subject: git proxy issue
Date: Mon, 16 Jul 2007 10:21:01 +0800
Message-ID: <6d6a94c50707151921h7f2a65fes65c94c3c1090937a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 04:21:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAGDD-0006I9-EZ
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 04:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407AbXGPCVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 22:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754898AbXGPCVE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 22:21:04 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:9380 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbXGPCVC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 22:21:02 -0400
Received: by nz-out-0506.google.com with SMTP id s18so707276nze
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 19:21:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ci9ffFk+H45Yu6YnYQLXLBWYuoS67iHDSknFGOI98r4dAtDOt0Zn9etvu2fRXbM/SE3X75Eh9PlLON9ESmDfWjT4rowxge9D4TI9jGPb0ddnEYWlsJcwHnQO+HYhiiT3gSgfEVG7v5Z5flM3p6qkGlWP6vvcyadtkERm4dask5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EfE5ovYDn6t0R0BO03EZE6oZWVFqcYJ74EsYqq4wwDfQ0avaLP/sjkPtxWVwm0B4WsFVmrDtWyjUkcNQPoiOfWy9XzhKkkcqKtmBVfdC3dBpCsav7fNghq3wo6rvr2SwvoEYs5GN8WAmr+/UpfB0Svqg85tz7ytSEdF6eUun6DU=
Received: by 10.142.177.7 with SMTP id z7mr280673wfe.1184552461193;
        Sun, 15 Jul 2007 19:21:01 -0700 (PDT)
Received: by 10.142.99.20 with HTTP; Sun, 15 Jul 2007 19:21:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52625>

Hi list,

I saw someone post a patch to make git support proxy, has it been applied?
From which release version git proxy is supported?
If not, how to do it?

Thanks,
-Aubrey
