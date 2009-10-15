From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Wed, 14 Oct 2009 21:02:38 -0600
Organization: icecavern.net
Message-ID: <200910142102.39920.wjl@icecavern.net>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca> <1255383459.15646.10.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 05:13:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyGlu-00062D-2n
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 05:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153AbZJODKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 23:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbZJODKw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 23:10:52 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:49427 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932867AbZJODKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 23:10:51 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2009 23:10:51 EDT
Received: from chocobo.localnet (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 92FB735A66
	for <git@vger.kernel.org>; Thu, 15 Oct 2009 05:02:43 +0200 (CEST)
User-Agent: KMail/1.11.4 (Linux/2.6.28-15-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <1255383459.15646.10.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130356>

On Monday 12 October 2009 15:37:39 Daniele Segato wrote:
> Il giorno lun, 12/10/2009 alle 01.28 -0400, sylvain@demarque.qc.ca ha
>
> scritto:
> > localhost / # git init
>
> I don't see the point of using git on the root directory :)

Just a comment: this might be of serious use in e.g. a chroot.
