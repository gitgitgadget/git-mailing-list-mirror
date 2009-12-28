From: Carlos Santana <neubyr@gmail.com>
Subject: immutable tags?
Date: Mon, 28 Dec 2009 14:04:42 -0600
Message-ID: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 21:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPLpn-0005rj-GW
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 21:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbZL1UEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 15:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZL1UEp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 15:04:45 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:50362 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbZL1UEo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 15:04:44 -0500
Received: by fxm25 with SMTP id 25so4810748fxm.21
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 12:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=x8s/2FBqyULNSRbvS9wjMMk6jFccOL8lkGBA2luyqYw=;
        b=i+OWf8dUXgtj1OrDaQ6yYsTdWJbjX/90zAq5IIsJ/jEeFrPY7kHxuFhL02D29fQtR+
         nyyeVXwAMVCD88LTbm/rMq8dik/oftrpHzX6uLHC9XZlq55MiZGuvV3NnRZugoLfXhaK
         b0T8Ixc8VJkaYkGFNnYCU7dlERvP+F3ijLzH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=OY7LfxMKhFhumye1Xnjna3UbkkDXpHOymAbji69ZQFeqZQ0827CSOK9EFRcjCVICZZ
         prDioswlQU/YPUv56xRpKjzKlYHE3Ug3QYlF+TtyxkXgHwINMzo42UTWdZycdb+ljzt8
         DT8VOOcueDHBr0NFHbuymmrhGku0a6boXtEwE=
Received: by 10.223.54.23 with SMTP id o23mr8231696fag.72.1262030682959; Mon, 
	28 Dec 2009 12:04:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135754>

I would like to know if there is any difference between branches and
tags. Is it only conceptual - convention to be followed by a developer
or some technical difference?  e.g. : Is it possible to create
immutable tags so that nothing can be checked in to that 'tagged
directory'?

-
CS.
