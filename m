From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 00:17:11 -0500
Message-ID: <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <20071205.202047.58135920.davem@davemloft.net>
	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	 <20071205.204848.227521641.davem@davemloft.net>
	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	 <1196918132.10408.85.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Harvey Harrison" <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 06:17:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0976-0006te-LS
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 06:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbXLFFRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 00:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbXLFFRM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 00:17:12 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:5003 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbXLFFRM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 00:17:12 -0500
Received: by rv-out-0910.google.com with SMTP id k20so111403rvb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 21:17:11 -0800 (PST)
Received: by 10.142.115.10 with SMTP id n10mr1467479wfc.1196918231640;
        Wed, 05 Dec 2007 21:17:11 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Wed, 5 Dec 2007 21:17:11 -0800 (PST)
In-Reply-To: <1196918132.10408.85.camel@brick>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67242>

> While you won't get the git svn metadata if you clone the infradead
> repo, it can be recreated on the fly by git svn if you want to start
> commiting directly to gcc svn.
>
I will give this a try :)
