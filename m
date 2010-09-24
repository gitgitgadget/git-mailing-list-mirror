From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn error
Date: Fri, 24 Sep 2010 09:28:13 +0200
Message-ID: <4C9C530D.3040206@drmicha.warpmail.net>
References: <AANLkTi=5ficziLK8cfikotoxkgUDLfhAM_RLzCOcOv5U@mail.gmail.com> <AANLkTi=KGtBJ=6-YWUJCsbmBWfnr1Kh2i=LaZmgM=8t5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Nate Parsons <parsons.nate@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:28:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2ha-0002zN-F3
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab0IXH2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:28:07 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57138 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753178Ab0IXH2G (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 03:28:06 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 33FA55D8;
	Fri, 24 Sep 2010 03:28:05 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 24 Sep 2010 03:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=KCEVFKPZg52NZ5lGCeFvhnavQqk=; b=OtBytwpiHa/tEASKxLmYGykFfnJyNHep+PJwoVv55B7l/qDM+gOj5AVndFWXVl9K55eX4t0tm9RtkrUaK9yiv7uwKGdQcvSqw2ZGdojnTkzVZ55FZdhywuWlAy9GXZWEJgI6mdaTSoxatJiX8aH3mKGp1Z4E+7c8dQYe1hwHWHU=
X-Sasl-enc: VQFFmNSIslpaDg4AxfNh/P8uNIHPtO9lLuYeDsAjsX2j 1285313284
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 953325E22D1;
	Fri, 24 Sep 2010 03:28:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <AANLkTi=KGtBJ=6-YWUJCsbmBWfnr1Kh2i=LaZmgM=8t5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156953>

Nate Parsons venit, vidit, dixit 23.09.2010 21:45:
> Hi all,
> 
> I reproduced the problem on openSUSE, running git 1.7.3. I can't
> provide access to the subversion repository, but I can do anything
> else to help diagnose the problem.

How about providing some context of that error message, i.e. a
transaction log? Also: Is this from a fresh repo?

Michael
