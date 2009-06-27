From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: Fix t9138-multiple-branches to use svn_cmd
	and (cd ...) syntax.
Date: Sat, 27 Jun 2009 15:08:00 -0700
Message-ID: <20090627220800.GA8876@dcvr.yhbt.net>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com> <20090625093602.GA3997@dcvr.yhbt.net> <4A451F8A.9060501@xiplink.com> <20090626205738.GB25118@dcvr.yhbt.net> <4A4538C3.5060901@xiplink.com> <20090626215452.GC25118@dcvr.yhbt.net> <4A4634D7.9000607@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 00:08:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKg4A-00017d-9X
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 00:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbZF0WIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 18:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbZF0WH7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 18:07:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55238 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbZF0WH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 18:07:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17ECF1F43D;
	Sat, 27 Jun 2009 22:08:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A4634D7.9000607@xiplink.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122385>

Marc Branchaud <marcnarc@xiplink.com> wrote:
> Eric Wong wrote:
>>
>> Thanks Marc, sign-off?
>
> Doh!
>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>

Thanks Marc!  This and the other patch pushed out to
git://git.bogomips.org/git-svn

-- 
Eric Wong
