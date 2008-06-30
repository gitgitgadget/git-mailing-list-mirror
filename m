From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Patches for qgit on MacOS X
Date: Mon, 30 Jun 2008 11:00:59 +0100
Message-ID: <e5bfff550806300300s2a0c0e60sdaa86453116c531f@mail.gmail.com>
References: <48665027.3090406@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: ocroquette@free.fr
X-From: git-owner@vger.kernel.org Mon Jun 30 12:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDGD2-0007Am-It
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 12:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbYF3KBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 06:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755259AbYF3KBE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 06:01:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:36847 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729AbYF3KBD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 06:01:03 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1476574wfd.4
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 03:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zoaZRVLR5sw3ul8vGjJhu6bQcrvJ6Wobs4ieSH8627I=;
        b=cc4YP1mB2CZ+9H9Zs9LMqwesC2jUcrfoeYrkS8hiF+8bq97Or5YKAUxbdWcoTDf4IU
         SSA4xN+euSMdNmN6AD4NbgcfDMn4GO8e0/nSFuSCLeur+F+Bl7Kbt0bhwUZ4NjzSiaWg
         /xJbA7PGOUTnyqKmFp6goPrmfQC0J3UI+4ivc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KD8jkDv98lDm7d1rFcXV/M9PCTszvy1BgN9YhcZ9F4MFA5GqHLKuDSkLubWMyLTf2M
         oMsOmNHyBcvUkrMWJ8SLOvjtNBEmp1liWPIiYDcthPxYslIOnQmdUUlT3NYCjxecV09P
         IPKmqqZDZXP05v/l72QzmRdG+S5seX1acU15E=
Received: by 10.142.204.18 with SMTP id b18mr1795661wfg.126.1214820059583;
        Mon, 30 Jun 2008 03:00:59 -0700 (PDT)
Received: by 10.142.231.11 with HTTP; Mon, 30 Jun 2008 03:00:59 -0700 (PDT)
In-Reply-To: <48665027.3090406@free.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86898>

On Sat, Jun 28, 2008 at 3:52 PM, Olivier Croquette <ocroquette@free.fr> wrote:
> Hi all
>
> I have posted 2 patches against qgit to make it work (better) under MacOS X:
> http://sourceforge.net/tracker/index.php?func=detail&aid=2005126&group_id=139897&atid=744829
> http://sourceforge.net/tracker/index.php?func=detail&aid=2005125&group_id=139897&atid=744829
>
> Comments are welcome.
>

Thanks for the patches, I'll apply them.

Can I ask why don't you use qgit-2.X series ? being based on Qt4
should be much easier to make it work under MacOS X and it's a better
qgit overall.

Thanks
Marco
