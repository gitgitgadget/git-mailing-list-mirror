From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Newbie questions regarding jgit
Date: Tue, 11 Nov 2008 15:11:06 -0800
Message-ID: <20081111231106.GT2932@spearce.org>
References: <4919EECB.7070408@wellfleetsoftware.com> <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com> <20081111214434.GS2932@spearce.org> <2c6b72b30811111401i3c995889n54407243a1072599@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Farrukh Najmi <farrukh@wellfleetsoftware.com>, git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 00:12:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L02PM-0001PJ-JX
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 00:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbYKKXLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 18:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbYKKXLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 18:11:09 -0500
Received: from george.spearce.org ([209.20.77.23]:36416 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbYKKXLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 18:11:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id CF676381FF; Tue, 11 Nov 2008 23:11:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2c6b72b30811111401i3c995889n54407243a1072599@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100690>

Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> 
> I don't think admin rights are necessary as long as I have
> "commit"/webdav access. And no svn or git-svn interaction should be
> needed to upload to the maven repository.
> 
> Take a look at the distributionManagement section of the
> google-maven-repository:
> 
>  - http://google-maven-repository.googlecode.com/svn/repository/com/google/google/1/google-1.pom
> 
> Looks pretty easy to set up. About maintaining it, I don't mind doing
> "mvn deploy" once in a while, but some kind of update policy should
> probably be worked out in any case.

Then have at it.  It sounds like it would be worthwhile setting up.

-- 
Shawn.
