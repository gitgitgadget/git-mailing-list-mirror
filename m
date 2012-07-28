From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Extract remaining classes from git-svn
Date: Sat, 28 Jul 2012 04:12:23 +0000
Message-ID: <20120728041223.GB6129@dcvr.yhbt.net>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
 <20120728004026.GA5363@dcvr.yhbt.net>
 <7vfw8cy1gv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com,
	"Michael G. Schwern" <schwern@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 06:12:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuyOE-0004u7-Vz
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 06:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab2G1EMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 00:12:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36703 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924Ab2G1EMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 00:12:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A371F43A;
	Sat, 28 Jul 2012 04:12:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vfw8cy1gv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202402>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > "Michael G. Schwern" <schwern@pobox.com> wrote:
> >> This series of patches extracts the remaining classes from git-svn.  They're
> >> all simple extractions and functionally have no change.
> >
> > I've also pushed this to the "extract-remaining" series which
> > also includes everything that's currently in my master.
> 
> Do you mean this should go in 1.7.12-rc1, or your master is for
> 1.7.12 and this is for post 1.7.12 but you are pushing it out to
> help other developers who are working on git-svn as a preview?

I'm comfortable with this series so far, so going into 1.7.12 is fine.
I pushed to a different branch because I didn't want to change the
commit on my previous pull request, sorry if I wasn't clear :x

> I didn't look at these follow-up patches, but if you say they are
> fit for the upcoming release, that is good enough for me.  Just
> checking which way you want us to go.

I looked at them a few times and things seem good.  I wouldn't
mind an extra set of eyes, though :)
