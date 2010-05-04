From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to
	stop git-svn
Date: Tue, 4 May 2010 18:34:52 +0000
Message-ID: <20100504183452.GA30894@dcvr.yhbt.net>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com> <1271880470.20208.47.camel@denix> <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com> <4BCF8E07.9080507@vilain.net> <r2jc8b3bef91004280851i865a911ei47b1be606dd560d9@mail.gmail.com> <20100503211942.GA1380@dcvr.yhbt.net> <4BDFC171.5010103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Olson <mwolson@gnu.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org, Tim Stoakes <tim@stoakes.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 04 20:35:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9MxV-0000pa-5Y
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 20:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881Ab0EDSez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 14:34:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45984 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206Ab0EDSez (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 14:34:55 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B961F505;
	Tue,  4 May 2010 18:34:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4BDFC171.5010103@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146336>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Uhm, which one: The one in your subject line or the one in the quoted
> subject line?

Sam's patch:
  Subject: [PATCH] git-svn: deal with svn cherry-picks with non-linear history

Where he said:
> >>> Oh, right ... I remember that issue now. I'm currently testing the
> >>> below change to see if it breaks the test suite; any issues and I'll
> >>> post an update.

Sorry for the confusion

-- 
Eric Wong
