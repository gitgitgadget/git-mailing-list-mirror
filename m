From: "Ping Yin" <pkufranky@gmail.com>
Subject: git adds some text file as binary file by mistake
Date: Fri, 24 Oct 2008 20:37:01 +0800
Message-ID: <46dff0320810240537i4f0d86b9p56def9ef6a69c180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 14:38:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtLvo-0000Ms-29
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 14:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbYJXMhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbYJXMhE
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 08:37:04 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:25471 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbYJXMhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 08:37:03 -0400
Received: by yx-out-2324.google.com with SMTP id 8so280891yxm.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 05:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MFRm55xFd2JbXOM/vbEj/76A8EuKysphoRlg28odqDw=;
        b=floiIH8lvKJsyw4wQvrhgdI0XyPffYC201BDkIKUvmKT62QB/VAsACpkDbWgcDrrMR
         lZpW4ba4jrBtgOyIIn4NltWKytGJotYG5YYSO3smG0gmG05lfe2dFDGASH3jwhgMEpCD
         ldlB2+Mv1wiRJWiq1mb42wnLZVRH8TWsZHK10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=qMGtihmzX+sxSs1lippQw1VtD8Oq6TSqdgjYG61gd/LxqHZDv5m3u1FU7Tb9/iJYz7
         mxsay2C1h+saS4UoSVZOkv2C9cmIGa1xPr1i7DwrYIx4qOvi1Dk7Wx0lbRl6+bP5miE2
         yqtMSIVah9+eLTx5oYD5CguFqozuzdoo2fumk=
Received: by 10.150.52.2 with SMTP id z2mr5763239ybz.210.1224851821493;
        Fri, 24 Oct 2008 05:37:01 -0700 (PDT)
Received: by 10.150.140.10 with HTTP; Fri, 24 Oct 2008 05:37:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99030>

So what should i do if i want it added as text file?

--
Ping Yin
