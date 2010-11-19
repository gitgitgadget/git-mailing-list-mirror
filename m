From: Dun Peal <dunpealer@gmail.com>
Subject: Best newbie / advanced / expert reference texts for Git?
Date: Fri, 19 Nov 2010 11:02:31 +0000
Message-ID: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 12:03:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJOkL-0008Mv-0L
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 12:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab0KSLCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 06:02:32 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36242 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab0KSLCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 06:02:32 -0500
Received: by qyk7 with SMTP id 7so113271qyk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 03:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=4CTVBvB5RXU9FF2iK7HeUfO6I+clJlfy5MQuDp3ho6I=;
        b=dzMN5x7VR79ab3FIgw2VpGUGpd/At6D8vCze8Y7GkB5EGDGYM79qsxSuWbIjJcjYzR
         0ssmTK+ABJaPHd9V9S43QuHWJyBf08BKBUERd9C65gpVa1kFv7hxT85swlGVExltWnzW
         +X6tyIlXN6/h+0XTwGQm+sAtYka+pGsnSubgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vE8motc2655Z6hyZmYkpwhkwa7QOxK3P8kr+263c5dctzzHncBZMcLM7xAPNzHBiDg
         7GN7fYmyEc07bJ/ZxO1TAXn0IOMX5YSsMqIA2J4ylJjPfGwOfSN5avUGzxtdgb2NppeQ
         uT69foiEpYgFgI36TGateiLglnnxSu/ViYopE=
Received: by 10.229.181.85 with SMTP id bx21mr1680485qcb.227.1290164551398;
 Fri, 19 Nov 2010 03:02:31 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Fri, 19 Nov 2010 03:02:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161734>

Hi there,

What are the best texts for the following three levels of knowledge:

1. Newbie: someone who used a simple, centralized SCM (such as SVN)
but never touched Git.
2. Intermediate: someone who uses Git's simpler features, and can do
simple branching/merging, but would like to fully understand the
underlying concepts such as the DAG, and master all common user-level
operations such as branching, merging, and rebasing.
3. Advanced: someone who knows all the above, but would like to know
everything there is to know about Git.

The target audience in my particular case is smart, with strong CS
background, especially those in the two latter categories.

Being available online is a plus, but will not disqualify a good
offline reference.

Thanks, D
