From: Andy Parkins <andyparkins@gmail.com>
Subject: templates/branches--
Date: Tue, 24 Apr 2007 13:41:51 +0100
Message-ID: <200704241341.54857.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 14:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgKLO-0002NG-2n
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 14:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbXDXMmD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 08:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbXDXMmD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 08:42:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:33584 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbXDXMmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 08:42:01 -0400
Received: by ug-out-1314.google.com with SMTP id 44so168151uga
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 05:41:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NHOC48O5zPN1Km+IL303fS3c24y2+sPi8wqAdQOdkrbWZrhFFPUFtyR076D/zPLOftJ35fWk4j8ZcSbhrC98mCgdWMUSgVhPXfgy0FgdkeLcjVyEuodoeuHVtUglV827X00KmcN0VMXJ1Uv7sNWzxaXj4KHM2t7HwyoRB9AM+e8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eb3RRU9t1KQkWhJE3QtRstKUwZe0apkDdiuAvAzBEFGpHA4g4Jbui6WW8L/Ab/Hn20jvlfZWqzg/Uptu1pMb2dD2MeIu4dKFxFU0HdwpAElilrM6oSa9gp2kvETOyLnpgbKO3mLrCHLA0jwCDwick/INrs8/ycq3pu1AbY6N78Q=
Received: by 10.82.188.15 with SMTP id l15mr718529buf.1177418519420;
        Tue, 24 Apr 2007 05:41:59 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y37sm28158iky.2007.04.24.05.41.57;
        Tue, 24 Apr 2007 05:41:58 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45446>

Hello,

Is there a reason for the branches/ directory to be in the default git 
template?

The first thing I do with a new repository is remove branches/ and remotes/ 
and everything seems to work fine.

Would it be safe to remove templates/branches-- so it's never even installed?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
