From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 17:09:08 +0700
Message-ID: <fcaeb9bf0710160309y51101fbaicae463a10612010c@mail.gmail.com>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site>
	 <4713B367.52CEC7E2@dessent.net>
	 <Pine.LNX.4.64.0710151938300.25221@racer.site>
	 <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home>
	 <4713C81F.A75FEFC2@dessent.net>
	 <Pine.LNX.4.64.0710152117290.25221@racer.site>
	 <7287AD62-3274-4B20-881C-D02E08C4B2EF@zib.de>
	 <fcaeb9bf0710151924r258dd561hd13c22319d17f80f@mail.gmail.com>
	 <uprzfithw.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: prohaska@zib.de, git@vger.kernel.org, raa.lkml@gmail.com,
	ae@op5.se, tsuna@lrde.epita.fr, Johannes.Schindelin@gmx.de
To: "Eli Zaretskii" <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:11:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhjMd-0004Uq-FN
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 12:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbXJPKJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 06:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbXJPKJN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 06:09:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:10633 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbXJPKJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 06:09:10 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1792037fkz
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GUtQKu01AGzI02H21M6/hPjTpv0l4+pafXoaXDxx8Nw=;
        b=DFHmPVW9GGSyCnfxMhA3vsPuZ/6jVfB3YlWccDWQQ+s0XVRH+ULyFvxJO03f0WR3GBn3qzudwLwC+ZVQgjzkeehAtWiyFdfs621oCfAxgpsZhE60FDdkYk3PYqF0EgGqFt4kOjdwjD/yOi5KPeH+5Ciu83tSy7IERIP+NmLZMC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n0cwLQN4tvpQy2A4C8q1c9+V1VaIjKNyqv1Q0JCMm+p2B9aFiwuPKagTqToTGAZkQV24bjPsuO3RJrgH7T8pOwTSvw6eQbVxw0uWO5nFQtxAgKX9e0hFrjvtBxsV9xY0TgwltFhrnFSdRZ3nMmuBQMs3IcC80+XElBRiDbABurk=
Received: by 10.86.80.5 with SMTP id d5mr5767363fgb.1192529349211;
        Tue, 16 Oct 2007 03:09:09 -0700 (PDT)
Received: by 10.86.83.3 with HTTP; Tue, 16 Oct 2007 03:09:08 -0700 (PDT)
In-Reply-To: <uprzfithw.fsf@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61137>

On 10/16/07, Eli Zaretskii <eliz@gnu.org> wrote:
> > Date: Tue, 16 Oct 2007 09:24:50 +0700
> > From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
> > Cc: "Git Mailing List" <git@vger.kernel.org>, "Alex Riesen" <raa.lkml@gmail.com>,
> >       "Eli Zaretskii" <eliz@gnu.org>, "Andreas Ericsson" <ae@op5.se>,
> >       tsuna@lrde.epita.fr,
> >       "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> >
> > I did try hard to find the legendary
> > zsh for Windows before giving up and porting busybox's ash instead.
>
> Where can one find this port of busybox's ash?
>

http://repo.or.cz/w/git/pclouds.git?a=shortlog;h=gitbox

In directory box/shell.
-- 
Duy
