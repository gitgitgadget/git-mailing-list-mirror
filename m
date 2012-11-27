From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: gitpacker progress report and a question
Date: Tue, 27 Nov 2012 03:36:39 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121127083639.GA26935@thyrsus.com>
References: <20121115212818.GA21558@thyrsus.com>
 <CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
 <20121126220108.GB1713@thyrsus.com>
 <CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
 <20121126234359.GA8042@thyrsus.com>
 <CAMP44s3=VpMv-S2eV9rXRaH9U3SvaR8B6Dto=vAmVQ_XB1uBXg@mail.gmail.com>
 <20121127072700.GA23169@thyrsus.com>
 <CAMP44s1=sjWypEN3zzC=aPqZYnBFU0C+Dhrh3zj=jY57PHJ6wg@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:37:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdGf3-0004B1-MF
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 09:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab2K0Igm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 03:36:42 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:55085
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757488Ab2K0Igm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 03:36:42 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 96B8F40661; Tue, 27 Nov 2012 03:36:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1=sjWypEN3zzC=aPqZYnBFU0C+Dhrh3zj=jY57PHJ6wg@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210542>

Felipe Contreras <felipe.contreras@gmail.com>:
> Most of those old projects have a linear history,

INTERCAL didn't.  There were two branches for platform ports.

> But different commit/author and respective dates, and merges? Sounds
> like overkill.

I felt it was important that the metadata format be able to specify
git's entire metadata and DAG semantics.  Otherwise, as sure as the
sun rises, *somebody* would run into a corner case not covered, and
(quite rightly) curse me for a shortsighted fool who had done a
half-assed job.

I don't do half-assed jobs.  Not ever, no way, nohow.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
