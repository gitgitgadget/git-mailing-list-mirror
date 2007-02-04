From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [ANNOUNCE] cgit v0.2
Date: Mon, 5 Feb 2007 00:44:08 +0100
Message-ID: <8c5c35580702041544o61458e8at6cd83be672b8254f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 00:44:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDr24-0006pL-Tn
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 00:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbXBDXoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 18:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbXBDXoM
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 18:44:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:47364 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbXBDXoM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 18:44:12 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1952863nfa
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 15:44:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iTkIMRmeoC6KeL8wdBVx5BYCpz9wCySDNMqsJfbuxfj0xIIXwwHXFiucLPbXStdJ3SWXCTyZ5lLsOWEvzJACUOCsfyX+KfWgsI23w5M7FyJEZEvnwJfqK/VHogEqantsKjaWNQjmOev8qJ54Umexpu44M6jk2mnMSXRO5PFvvqQ=
Received: by 10.82.182.8 with SMTP id e8mr378268buf.1170632648939;
        Sun, 04 Feb 2007 15:44:08 -0800 (PST)
Received: by 10.82.158.7 with HTTP; Sun, 4 Feb 2007 15:44:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38713>

A new release of cgit is available for cloning from

  git://hjemli.net/pub/git/cgit

or browsing at

  http://hjemli.net/git/


Main changes since v0.1:
  -list tags in repo summary
  -allow search in log-view
  -read repository paths from cgitrc


-- 
larsh
