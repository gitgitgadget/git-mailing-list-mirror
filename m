From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Qt git repository report
Date: Wed, 31 Jan 2007 11:57:38 +0100
Organization: At home
Message-ID: <eppskj$1l4$2@sea.gmane.org>
References: <200701310912.59102.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 12:00:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCDCE-0005CI-VR
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 12:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023AbXAaLAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 06:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933020AbXAaLAG
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 06:00:06 -0500
Received: from main.gmane.org ([80.91.229.2]:55095 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933025AbXAaLAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 06:00:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HCDC6-0000yF-Gu
	for git@vger.kernel.org; Wed, 31 Jan 2007 12:00:02 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 12:00:02 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 12:00:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38240>

Andy Parkins wrote:

> It's always nice to read positive reports, so I thought I'd point you all at 
> this one.
> 
> One of the Qt developers posted a blog entry describing the conversion of the 
> Qt repository from perforce to git.
> 
> http://qtdeveloper.net/archives/2007/01/30/fun-with-git/
> 
> Key facts:
>  * 13 years worth of changes
>  * 94000 revisions
>  * 736774 objects
>  * Took 3 hours to convert using git-fast-import and a custom script
>  * Repository size: 500MB
>  * Checkd out tree size: 330MB
> 
> I never cease to be amazed by how good git is at its job.

By the way, do any of you know how large original Perforce repository is?
(And why Trolltech uses Perforce from all proprietary and OSS SCMs?)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
