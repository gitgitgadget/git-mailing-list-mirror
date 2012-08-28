From: Stephen Bash <bash@genarts.com>
Subject: Re: diff/merge tool that ignores whitespace changes
Date: Tue, 28 Aug 2012 14:08:14 -0400 (EDT)
Message-ID: <1897335562.100848.1346177294831.JavaMail.root@genarts.com>
References: <503D02DF.3030802@redlion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Enrico Weigelt <enrico.weigelt@vnc.biz>, git@vger.kernel.org
To: Matthew Caron <Matt.Caron@redlion.net>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:08:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6QDE-00074i-6E
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab2H1SIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:08:22 -0400
Received: from hq.genarts.com ([173.9.65.1]:8146 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751691Ab2H1SIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:08:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id DF87DBE12E0;
	Tue, 28 Aug 2012 14:08:20 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q1MRJWb473ZO; Tue, 28 Aug 2012 14:08:14 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id D6EC4BE137B;
	Tue, 28 Aug 2012 14:08:14 -0400 (EDT)
In-Reply-To: <503D02DF.3030802@redlion.net>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC21 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204445>


----- Original Message -----
> From: "Matthew Caron" <Matt.Caron@redlion.net>
> Sent: Tuesday, August 28, 2012 1:41:51 PM
> Subject: Re: diff/merge tool that ignores whitespace changes
> 
> > > I'm looking for a diff / merge tool that treats lines with only
> > > whitespace changes (trailing or leading whitespaces, linefeeds,
> > > etc) as equal.
> > >
> > > The goal is to make reviews as well as merging or rebasing easier
> > > when things like indentions often change.
> > >
> > > Does anybody know an solution for that ?
> 
> I'm fond of Meld.

I loved Meld when I was working exclusively on Linux several years ago.  Honestly I think I set up my kdiff fonts/highlight colors/etc. to be very Meld-like (unintentionally, just what "looked right").  Looking at the website, technically Meld should build/run on a variety of OSes, but at some point (lost to the sands of time) I ran into trouble which is why I switched.

Stephen
