From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC 11] Sequencer: Acceptance
Date: Tue, 26 Apr 2011 10:20:18 +0530
Message-ID: <20110426045016.GA20182@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 06:51:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEaEz-0006VM-BM
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 06:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab1DZEvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 00:51:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44003 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab1DZEvF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 00:51:05 -0400
Received: by pvg12 with SMTP id 12so205134pvg.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 21:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=C2Pa7s4B2+CqfQrdXWZyh8wv6k7UvabeI8466gyTEuw=;
        b=A0hvvGVqmEM3Heyr1QNyUlIAQKPrlwWHTYXODPNd4IQ/C5jEQRJFvutg3urvtvhwfS
         mikPr9zdk6i7mu2PGoSOgYaGjuRolaFhNbs6pzMMlbIYCLMesfDkPpi/ftPRhlSzitaW
         GhFaNc67bJoWdyoATqhH1zp1KP5s0bzm00z/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=l79CXtBsTkVA2bc1TUF17ol4QpRXc8UTZ9P2ReODa9r+2wcjeYUFmhxpCbtB3wKXcI
         XcQ6MSnRx8ngNIALHRnARnafKqjsf/iprHOkWkkLkEbLWQmLHFtv2z6EbGCScATKPzPQ
         PRLKBtko2vUSqu9CzqlomgiyoCLJzL8sr4f1Q=
Received: by 10.68.4.38 with SMTP id h6mr470381pbh.143.1303793464672;
        Mon, 25 Apr 2011 21:51:04 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n7sm4308840pbi.2.2011.04.25.21.51.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2011 21:51:03 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172064>

Hi,

I've been accepted into the GSoC 2011 program to work on the
sequencer, and Chistian has graciously agreed to mentor me [1].  For
more details, please refer to the series I posted a few weeks ago
[2]. All updates related to the project will be prefixed with "[GSoC
11] Sequencer: " in the subject line, so it should be easy to follow.

I have exams until the end of the month, so I expect to start working
early next month.

I look forward to working with Christian and the Git community.

Thanks.

[1]: http://socghop.appspot.com/gsoc/project/google/gsoc2011/artagnon/9001
[2]: http://thread.gmane.org/gmane.comp.version-control.git/171255

-- Ram
