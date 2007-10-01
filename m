From: "Tom Clarke" <tom@u2i.com>
Subject: Re: How to re-use setups in multiple tests?
Date: Mon, 1 Oct 2007 14:46:46 +0200
Message-ID: <550f9510710010546q55209759k4770cd3e78121cfc@mail.gmail.com>
References: <550f9510710010327l3e729ff1tbbb9b6c674c1cb11@mail.gmail.com>
	 <Pine.LNX.4.64.0710011243230.28395@racer.site>
	 <550f9510710010516s305c843br53da294f65318862@mail.gmail.com>
	 <Pine.LNX.4.64.0710011336530.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 14:46:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcKfo-00068Q-Se
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 14:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbXJAMqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 08:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbXJAMqt
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 08:46:49 -0400
Received: from el-out-1112.google.com ([209.85.162.178]:28491 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbXJAMqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 08:46:49 -0400
Received: by el-out-1112.google.com with SMTP id v27so735582ele
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 05:46:48 -0700 (PDT)
Received: by 10.114.95.1 with SMTP id s1mr663954wab.1191242806944;
        Mon, 01 Oct 2007 05:46:46 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Mon, 1 Oct 2007 05:46:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710011336530.28395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59611>

On 10/1/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I suppose I could find the old pre-rebase head and work with that, but
> > that doesn't seem that clean to me.
>
> You can use "git reset --hard master@{1}", and it really escapes me why
> this should not be clean, and why you want to jump through hoops instead
> using a much more complicated technique.

That'll be because my git knowledge isn't good enough to make it
clean. Thanks for the suggestion :-)

-Tom
