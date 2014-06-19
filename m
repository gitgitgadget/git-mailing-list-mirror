From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Tool/Scripts - For maintaining different branches on a repo
Date: Thu, 19 Jun 2014 16:18:22 +0530
Message-ID: <CAD6G_RRxj_tHhiGxP+ehNMBewqveUbbGuLLxgnHjUt96WkC_xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 12:48:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxZtL-0005ng-Ni
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 12:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358AbaFSKsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 06:48:24 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:46957 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbaFSKsX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 06:48:23 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so1597510yha.38
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0GaTJSr+JNBFg2vWPeJ+3l30frYLePEm0KjjkxBtiPc=;
        b=UMZCTUo53zHiv6ROTNYPEClGdaZnCsPjD1/hlgpc2GzeruhWB9x6iUS7p+vdmIttOu
         yIm2ce+QDgJ/DBgV+QIGD2zPlZjC/SVs30lqCAgtovsyQJ9f16aLdZtL4KOha0coo3dD
         KVllmbCLzhmo3PMpHXOvsWhWL+ohsA1XyMBqt2/Ehk0CsgpAzKHtNQSmslVPAknTw1Kf
         ObL1fECHSUSCZ6Dv15OuAfzQrpl1IdGNpAT8caigiYRoZh5574w/ab6BVxLKs5KjNHk8
         JAYZ/gGlfhmCyo8yXh5iLuE77CeIZcvdd/Byb40Q/MOrgpInSa0c2ATDaCJ6f0eYc/Jx
         MYeg==
X-Received: by 10.236.14.34 with SMTP id c22mr6179762yhc.97.1403174902633;
 Thu, 19 Jun 2014 03:48:22 -0700 (PDT)
Received: by 10.170.99.195 with HTTP; Thu, 19 Jun 2014 03:48:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252108>

Hi,

I have a single repo with different kinds of branches say 4 branches.
Developers will send a patches wrt to specific branch.

Is there any opensource tool/script that does applying patches/maintaining
the branches in repo w/o manual intervention?

thanks!
-- 
Jagan.
