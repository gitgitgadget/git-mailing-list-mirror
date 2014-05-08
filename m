From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Bash v4 on msysgit?
Date: Thu, 8 May 2014 15:50:24 -0500
Message-ID: <CAHd499Dx2iiKc9sy6wJwO3_Jofbp1kwptTAXNvtrZ4DLgkGe8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 08 22:50:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiVGv-00084n-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 22:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbaEHUu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 16:50:26 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:43131 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbaEHUuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 16:50:25 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so4075098vcb.29
        for <git@vger.kernel.org>; Thu, 08 May 2014 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=T87wh9Xu0TCecDivbi6eGPmEsn6gIsXfNDN/abKyFHs=;
        b=mS3DPzlW6fWQFxPWVEo4lLB159RzvyMQSPZUY/etwJ15fLJcUzv9Je1OwEqjLFk7FS
         hfd1PWK5BDYw5zeHtwSJmCFwukJCvBxboyga6+wSk1mgmkDugqWpx+TJyGyZZAuBpqY9
         yk8ne9tYDrZMW3jJUnmSp+lF+2eBPM1c/OsB2RPfhG++rCxHmuSEOQX4cCoqHn1hWmMs
         B3Jo/ndrXWBR7wowDLJTaUJi5BU5HFssbzgqiNo/jPcRqML6Fs7wI05KqM29Nx3OC6b1
         XEaoxtxs7ryfTy56N89bRQu667iVNfyFP0R541CcEQeADKlWEq2h1Kmt6eTIX+EDnsk/
         lkoA==
X-Received: by 10.220.89.4 with SMTP id c4mr2379589vcm.53.1399582224986; Thu,
 08 May 2014 13:50:24 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.13.198 with HTTP; Thu, 8 May 2014 13:50:24 -0700 (PDT)
X-Google-Sender-Auth: LNj3swEKqSHRmLJIMjtbEjLCMpY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248445>

How can I get Bash v4 for msysgit 1.9.2? I need it for 'globstar'
shopt support. Thanks in advance.
