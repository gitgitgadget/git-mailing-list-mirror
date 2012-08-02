From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: New git.pot is generated for the upcoming git v1.7.12
Date: Thu, 2 Aug 2012 09:52:13 +0800
Message-ID: <CANYiYbGZWyCQxoTJpR1aOng3e2yrE+sjL1aR-ke62U1dYOztLA@mail.gmail.com>
References: <CANYiYbFLy4s3q1Tn9FD1ASLwY1=AND_ePqhHpC_X_nvb1iLoCA@mail.gmail.com>
	<7vvch5osmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>
X-From: git-owner@vger.kernel.org Thu Aug 02 03:52:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwkaJ-0004Ee-O0
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 03:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab2HBBwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 21:52:14 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58958 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2HBBwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 21:52:13 -0400
Received: by ggnl2 with SMTP id l2so810857ggn.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 18:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FWWSl/XjUCewgxAG9OMAUn2DSdwVfV03/+XQ7k4zTrY=;
        b=rVTwncqTymJk3BDDpqFZtnEj5fjYdcuuw9VYy8EeF67eCMfb71u/JDiCTchLtzL9pB
         lLkBBAVJWuWk4+ukzlezDnl6w211+3zyX0NNOJhKpMAahDkm0nFevumXXDKZscyWwrpV
         QzWTuipWhLf/QpsWmPUeSkxsthjXhgw8DJ19/5kzhGZdrV7mgVNUgj4UvIICc7tUp98S
         BtwuiW2Fs0TJ3nCYlOuAbuuFn6IEfs9YTl7aiTcYDliCGr9p4d4FesnlBqsJ419HPOh9
         FzLwHvBYDp/cBi5JhMEdnExOWEGXW6QrSMYafpFk6WDAkB4tzn4OWeUyjEkBtPVvP2xx
         DXcA==
Received: by 10.50.237.34 with SMTP id uz2mr374863igc.19.1343872333040; Wed,
 01 Aug 2012 18:52:13 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Wed, 1 Aug 2012 18:52:13 -0700 (PDT)
In-Reply-To: <7vvch5osmb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202742>

L10n teams,

As Junio has already merged i18n topic branches and last round of l10n
commits, New round of translation begins. This update of "po/git.pot" is
not trival.

You can fetch this update at the usual place and start translation:

 * https://github.com/git-l10n/git-po/commits/master

Commit log for this update:

    l10n: Update git.pot (76 new, 4 removed messages)

    Generate po/git.pot from v1.7.12-rc1-16-g05a20, and there are 76 new,
    4 removed l10n messages.

     * 76 new messages are added at lines:

       230, 337-580, 4972, 4984, 4998, 5017, 5280-5378, 5654

     * 4 old messages are deleted from the previous version at lines:

       230, 4729, 4764, 5295

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>


-- 
Jiang Xin
