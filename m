From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: How do gmail users try out patches from this list?
Date: Tue, 11 Aug 2009 19:17:17 -0600
Organization: icecavern.net
Message-ID: <200908111917.19267.wjl@icecavern.net>
References: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com> <20090811221408.GC12956@vidovic>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Aug 12 03:17:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb2T8-000702-Gg
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 03:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbZHLBR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 21:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbZHLBRZ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 21:17:25 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:42161 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754495AbZHLBRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 21:17:25 -0400
Received: from chocobo.localnet (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 9EBA635A2B;
	Wed, 12 Aug 2009 03:17:22 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-15-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090811221408.GC12956@vidovic>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125640>

On Tuesday 11 August 2009 16:14:08 Nicolas Sebrecht wrote:
> The 11/08/09, skillzero@gmail.com wrote:
> > Sorry if this is dumb question, but I didn't see any good info in my
> > searches.
> >
> > How do gmail users normally apply patches that come through the list?
>
> It doesn't rely on your address mail provider but on your local email
> workflow/MUA.

I'm not in this situation, but my guess is that a lot of people use gmail 
primarily through the web interface (e.g. because of corporate firewalls or 
some other reason). Maybe someone in that situation should make an new "git 
imap-am" command? Kind of the reverse to imap-send. Just a thought. =)
