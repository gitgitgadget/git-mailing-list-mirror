From: public_vi <public_vi@tut.by>
Subject: Re: [PATCH] git-svn: add --ignore-paths option for fetching
Date: Mon, 26 Jan 2009 00:48:54 +0200
Message-ID: <497CEC56.3020900@tut.by>
References: <1232864842-8841-1-git-send-email-public_vi@tut.by> <200901251521.15591.trast@student.ethz.ch> <20090125224238.GA31581@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jan 25 23:52:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDpo-0000fJ-Ok
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbZAYWun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbZAYWun
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:50:43 -0500
Received: from mail.tut.by ([195.137.160.40]:34807 "EHLO speedy.tutby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbZAYWun (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:50:43 -0500
Received: from [91.149.148.191] (account public_vi@tut.by HELO [91.149.148.191])
  by speedy.tutby.com (CommuniGate Pro SMTP 5.1.12)
  with ESMTPSA id 136641678; Mon, 26 Jan 2009 00:49:20 +0200
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20090125224238.GA31581@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107117>

Eric Wong wrote:
> Thomas Rast <trast@student.ethz.ch> wrote:
>   
>
> Also, indentation is always done with tabs in git-svn (and the vast
> majority of git as well).
>
>   
Whitespace is invisible for me now, I only checked according to 
Documentation/SubmittingPatches about extra lines adds or removes caused 
just by whitespace difference.
>
>
> Vitaly: thank you for the patch.  Can you also provide a testcase to
> ensure this functionality doesn't break during refactorings?  Thanks.
>
>   
Already done it with testcase. There are two new packs of patches sent 
to git@vger.kernel.org, the first is outdated too, the second is current.
(I don't yet completely know how things should be done).
