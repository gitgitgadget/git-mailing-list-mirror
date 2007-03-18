From: F <ff.pptux@gmail.com>
Subject: any info getting a birdview of Git and its test suite?
Date: Sun, 18 Mar 2007 15:43:30 +0800
Message-ID: <3b051c1a0703180043n1dec45by90e5cee3393d2b4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 08:43:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSq3C-0007rl-PG
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 08:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbXCRHnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 03:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbXCRHnc
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 03:43:32 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:48172 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbXCRHnb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 03:43:31 -0400
Received: by nz-out-0506.google.com with SMTP id s1so462270nze
        for <git@vger.kernel.org>; Sun, 18 Mar 2007 00:43:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GjLiNNrSvT7/9f02GGIHF2Lre8Q4sp5ui7t+Q8hnS1Kegx8Ed1kr9gEQEvXWmIX2ntBKGCyIWyDwvMt7/+LJnHJWNqkBvidquj/QCFK6aFwN9PsLq8vQ2cxCTISaQBZWc6Vz28biIrOFsg6APQWQoEtEFZdzdT8903Vap3PATFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bgfLkMWD2c8Q5fKjc0m1cnLamdTVaPf7m60/KGLIhcSck1WclBDESH7b0LlNU9VwBeQUgrClIop5pzmTIlo/9hkZBoU57NuEzcrss65RxyQX+3TMhAZl9qAVXxt9sZUQ10oklsenvROOs08u377nPNIZeozJxNLxl7s9CGL35VU=
Received: by 10.35.91.10 with SMTP id t10mr5691395pyl.1174203810789;
        Sun, 18 Mar 2007 00:43:30 -0700 (PDT)
Received: by 10.35.41.9 with HTTP; Sun, 18 Mar 2007 00:43:30 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42479>

Hi,
    I'm interested in the "More Complete Tests" project in SoC2007.
I've used Linux for about more than one year and know basic bash
skills. I've downloaded the source of Git and read some test scripts
in the t directory. But I get confused.

    As said in the gitwiki page, I'm new to Git and Open Source
Development. I just know the basic usage and cannot figure out how one
component interacts with each other in a few days. It's hard for me to
write a decent plan on how to impove existing test scripts and on
writing a new one. So is there any infomation getting a birdview of
architecture of Git and its test suite? Or the only way is to read the
code?

    By the way, are there many experienced guys applying for this project?
    Thanks very much!
-- 
pptux
