From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: git-send-mail in sh
Date: Mon, 28 Nov 2005 01:15:41 +0100
Message-ID: <20051128001541.GB8811@puritan.petwork>
References: <4386DD45.6030308@op5.se> <7v7jaxou5b.fsf@assigned-by-dhcp.cox.net> <43874935.2080804@op5.se> <7vwtiwmvfp.fsf@assigned-by-dhcp.cox.net> <4388E33A.8000004@op5.se> <7v4q5xbvip.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 28 01:16:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgWgS-00005X-Cp
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 01:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVK1APn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 19:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVK1APn
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 19:15:43 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:25784 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751162AbVK1APm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 19:15:42 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep02.bredband.com with ESMTP
          id <20051128001541.UKXO9142.mxfep02.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Mon, 28 Nov 2005 01:15:41 +0100
Received: by puritan.petwork (Postfix, from userid 1000)
	id 23E29ADFE5; Mon, 28 Nov 2005 01:15:41 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4q5xbvip.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12837>

Junio C Hamano wrote:

> The ${parameter##word} syntax is in IEEE 1003.1-2001, and bash, ksh,
> and dash seem to work with it.

You can add Zsh to that list.

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
