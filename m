From: "Ping Yin" <pkufranky@gmail.com>
Subject: How to change a submodue as a subdirectory?
Date: Wed, 14 Nov 2007 22:37:57 +0800
Message-ID: <46dff0320711140637s51e1368fv3f632b6f04d093d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 15:38:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsJNk-0002jl-Tv
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 15:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbXKNOiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 09:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755020AbXKNOiD
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 09:38:03 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:12181 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbXKNOiB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 09:38:01 -0500
Received: by py-out-1112.google.com with SMTP id u77so2766111pyb
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 06:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=X29quc53bT5NKKP7wEQbsRJDwSd34fx+Wel+S8y8sWM=;
        b=h3JAwwn5Nu/ItDiMWimucCYWz621TamFxRmgbIppXwzQWqVhxZaqE4SaCJhINhw64nLk1MOGCVntgr9giceucnsgb7DISAk+TOZ56MVODS352wISWjUc/c0zD1yoqrNNDLpBpjyh+ldYuSnuXtIun3mxjA2ZR54ExyWohJ8RRWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jaqcrJek38b7nFykiHD+0gNwpQtG5EA8taBIMed3URVfqVOf4vQRIchC6ndbvEPLlwEuhzCY2BzRk03/jj7bkKkxJUKeZmbMAxHaKTkIlUMPE0JHVs+ft93aKIvYqLaEUOB/hP2dJ2avnH6O5nRVbfO+nHIzzrk04NOGZAP08RQ=
Received: by 10.35.92.18 with SMTP id u18mr8884339pyl.1195051077798;
        Wed, 14 Nov 2007 06:37:57 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Wed, 14 Nov 2007 06:37:57 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64987>

I have a super project superA, and a submodue subB. Now i decide to
switch subB from submodule to sub directory. Any good way to do that
and not losing any history?

-- 
Ping Yin
