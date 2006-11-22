X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Otavio Salvador <otavio@debian.org>
Subject: StGit metadata grabbing with git clone
Date: Wed, 22 Nov 2006 10:05:01 -0200
Organization: O.S. Systems Ltda.
Message-ID: <87ac2jwutu.fsf@neumann.lab.ossystems.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 19:16:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.90 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at freedom.ind.br
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32093>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmxZh-0003VF-5V for gcvg-git@gmane.org; Wed, 22 Nov
 2006 20:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756691AbWKVTP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 14:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756692AbWKVTP5
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 14:15:57 -0500
Received: from mail.freedom.ind.br ([201.35.65.90]:55728 "EHLO
 freedom.ind.br") by vger.kernel.org with ESMTP id S1756691AbWKVTP5 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 14:15:57 -0500
Received: from localhost (localhost [127.0.0.1]) by freedom.ind.br (Postfix)
 with ESMTP id 1E18017FF7 for <git@vger.kernel.org>; Wed, 22 Nov 2006 17:15:59
 -0200 (BRST)
Received: from freedom.ind.br ([127.0.0.1]) by localhost
 (internet.freedom.ind.br [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id
 28992-06 for <git@vger.kernel.org>; Wed, 22 Nov 2006 17:15:58 -0200 (BRST)
Received: from lab.ossystems.com.br (lab.ossystems.com.br [201.10.58.28]) by
 freedom.ind.br (Postfix) with SMTP id 2ED0D1CCAC for <git@vger.kernel.org>;
 Wed, 22 Nov 2006 17:15:58 -0200 (BRST)
Received: (nullmailer pid 6713 invoked by uid 1000); Wed, 22 Nov 2006
 12:05:01 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I'm a happy user of stgit together with git to maintain a patch queue
while I or the company team is working on patches that will be send
for merging. Both works great but we're having troubles when we try to
clone a stgit repository.

When I clone the repository it grab the source but it loses the
metadata. I would like to grab those too. Does anybody has a solution
or a trick how I can do that?

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://otavio.ossystems.com.br
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
