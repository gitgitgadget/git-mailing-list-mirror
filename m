From: Jakub Narebski <jnareb@gmail.com>
Subject: [GSoC 2011] What were the results of Midterm Evaluations of Git projects?
Date: Fri, 29 Jul 2011 21:02:12 +0200
Message-ID: <201107292102.13676.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 21:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmsKJ-0003Xp-Bw
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 21:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab1G2TCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 15:02:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57136 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1G2TCW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 15:02:22 -0400
Received: by wwe5 with SMTP id 5so3864464wwe.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m4Tw6yrU+dH+V+gjjL36y+R3cf0Nv5Dp3Q/C+aunhiM=;
        b=N3FczslWbEAfxplvbcOTX1F3yB32VGUPUIa7G+QRMI4YF2eGBQ5O9Obbxhikbq0ZTW
         lc5nuGJvkg3rUXPapf8OUvUc2YcEFfcb6eq3Yg15351liIkzc3cq0HkoSjJjkwb3Pb5M
         aIZzhtjOtj3hRa9LejEiS2Q2LnZZIio2CGnWs=
Received: by 10.227.11.141 with SMTP id t13mr2157574wbt.98.1311966141017;
        Fri, 29 Jul 2011 12:02:21 -0700 (PDT)
Received: from [192.168.1.13] (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id l68sm1634299weq.10.2011.07.29.12.02.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 12:02:19 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178159>

I guess that all five of Git projects for Google Summer of Code 2011:

 * Add the network stack to libgit2
 * Remote helper for Subversion and git-svn
 * Git submodule improvements
 * Git Sequencer
 * Port histogram diff from JGit

passed their midterm evaluations (July 11 -- July 15)... but I'd like to
be sure before updating https://git.wiki.kernel.org/index.php/SoC2011Projects

-- 
Jakub Narebski
Poland
