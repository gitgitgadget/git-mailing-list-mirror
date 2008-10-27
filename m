From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 00:15:11 -0400
Message-ID: <ee2a733e0810262115h705356dfmbc2237f8e88f3985@mail.gmail.com>
References: <ge0rla$mce$1@ger.gmane.org>
	 <ee2a733e0810260805n35c3a637v4739dda938a22518@mail.gmail.com>
	 <200810261955.10536.jnareb@gmail.com>
	 <200810270120.55276.arne_bab@web.de>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, "Jakub Narebski" <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Arne Babenhauserheide" <arne_bab@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 05:16:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuJWp-0002rP-As
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 05:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbYJ0EPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 00:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbYJ0EPP
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 00:15:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:15277 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYJ0EPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 00:15:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1796917fgg.17
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oTBsxd3pDkLdQOtkQp8dPRm0QJQ5hc+/9Ukq1cE3Kb8=;
        b=c68awasbYgnMbnuwGYJhIYNS2+tg4dTL3vjtLjYMWAYq+6Q/bbK78HfhpgqXvNHLlm
         7wok0foxdex164WwNyNk9bCZZdVnIo/rWpV4Bdve/75xn/ZLJUqYKlIcsNYJPUn8wWDa
         YlIZpyy0nqac1ozohyAUQAZWVCnPScN80oMZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=tQbCNpi9Oafpmn9snmozAyX1qQnmXLojfIoB+COLSjRATpg8PK/z3Fav7QjYBN1GIs
         1K9HHXl8U9O0+Z0y2wFmIfycsaWfKoyrfC7VspDAu8RpzN0JHLhl2bBZMDy/oCb/JtA2
         rQvRAMSCTp6nrEJqnyWgxnlfoNwdqFGXBfwos=
Received: by 10.187.195.12 with SMTP id x12mr477092fap.85.1225080911742;
        Sun, 26 Oct 2008 21:15:11 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Sun, 26 Oct 2008 21:15:11 -0700 (PDT)
In-Reply-To: <200810270120.55276.arne_bab@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99201>

On 10/26/08, Arne Babenhauserheide <arne_bab@web.de> wrote:
> Am Sonntag 26 Oktober 2008 19:55:09 schrieb Jakub Narebski:
>
> > > * Recently, Hg development seems to have somewhat slowed down. To
>  > >   simply put it, there is not enough room in the world for several
>  > >   similar SCM systems. With git's pace and momentum the other SCMs
>  > >   including Hg are fighting an uphill battle.
>  >
>  > The competing _distributed_ version control systems left seems to be
>  > Bazaar-NG (Ubuntu), Mercurial (OpenSolaris, Mozilla), Git (Linux kernel,
>  > Freedesktop.org, Ruby on Rails people).  There are many IDEs, many
>  > editors, many web browsers; there is Linux and there are *BSD; I hope
>  > that Mercurial would continue to be developed, and not vanish in
>  > obscurity like Arch and clones...
>
>
> Before we get tangled in this train of thought:
>
>  I created a head-to-head code_swarm of Mercurial and Git and it clearly shows
>  that Mercurial development didn't slow down.
>

I am not familiar with code swarms, sorry. My impressions are
subjective are thoroughly un-scientific:-)
(1) Judging by the activity of mailing lists git community is several
times larger and more active in terms of actual submitted patches.
(2) Hg forest extension is still not in the tree with outdated and
incorrect documentation in the wiki. For me it was biggest reason to
migrate from Hg to git.

--Leo--
