From: Kris Shannon <kris@shannon.id.au>
Subject: Re: [PATCH 0/2] git checkout: one bugfix and one cosmetic change
Date: Tue, 17 Mar 2009 15:56:12 +1100
Message-ID: <e51f4f550903162156i64b64900g815ee8317720f1a0@mail.gmail.com>
References: <cover.1237115791.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Mar 17 05:57:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjRNC-0006NZ-PU
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 05:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbZCQE4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 00:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZCQE4O
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 00:56:14 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:17450 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbZCQE4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 00:56:14 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2316372wfa.4
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 21:56:12 -0700 (PDT)
Received: by 10.142.237.20 with SMTP id k20mr2531178wfh.93.1237265772253; Mon, 
	16 Mar 2009 21:56:12 -0700 (PDT)
In-Reply-To: <cover.1237115791.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113418>

2009/3/15 Kjetil Barvik <barvik@broadpark.no>:
> Just one small bugfix patch, and one small cosmetic change.
>
> By the way, I wonder how often the list of 'Primary Authors' and
> 'Contributors' on the webpage http://git-scm.com/about is updated.
> Should'nt it be updated when a new release, like v1.6.2, is made?
>

I was rather surprised to see my name on that list.  A quick git log
showed my one contribution to git-parse-remote way pack in
August 2005.

I'd forgotten about that and was feeling all warm and fuzzy until I did:
git log -- git-parse-remote

and saw that it was deleted a week later :(
