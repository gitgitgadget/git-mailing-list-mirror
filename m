From: "Matt Seitz" <matseitz@cisco.com>
Subject: git gui equivalent to git checkout -b
Date: Mon, 28 Mar 2011 17:57:12 -0700
Message-ID: <imrapc$f7u$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 02:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4NFX-000155-3p
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 02:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab1C2A5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 20:57:30 -0400
Received: from lo.gmane.org ([80.91.229.12]:44229 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869Ab1C2A5a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 20:57:30 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q4NFQ-00012F-Rh
	for git@vger.kernel.org; Tue, 29 Mar 2011 02:57:28 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 02:57:28 +0200
Received: from matseitz by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 02:57:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.3664
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3664
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170210>

What is the git gui equivalent to "git checkout -b"?

I have a working tree with changes that I don't want to commit to "master" 
yet.  So I want to create a new branch to contain my changes.

If I go to "Branch->Checkout", I don't see an option to create a new branch.

If I go to "Branch->Create", I see an option to "Checkout After Creation", 
but I want to be sure that is the right choice.
