From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/2] Two janitorial patches
Date: Thu, 27 Aug 2009 11:16:32 -0500
Message-ID: <vODpKBYr5sNtCfB7C_mUMqGkpPTwc8quzfdAUjySMC_tekZRVbEOpzkstotoeMXAS6wJ4OaF2NA@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 18:16:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mghej-0005Os-DQ
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbZH0QQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbZH0QQs
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:16:48 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38312 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbZH0QQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:16:48 -0400
Received: by mail.nrlssc.navy.mil id n7RGGmGw031700; Thu, 27 Aug 2009 11:16:48 -0500
X-OriginalArrivalTime: 27 Aug 2009 16:16:47.0917 (UTC) FILETIME=[C7022DD0:01CA2731]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127168>

Brandon Casey (2):
  abspath.c: move declaration of 'len' into inner block and use
    appropriate type
  commit.c: rename variable named 'n' which masks previous declaration

 abspath.c |    6 +++---
 commit.c  |   10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)
