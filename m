From: =?iso-8859-1?Q?Damien_G=E9rard?= <damien@iwi.me>
Subject: Re: git-p4: exception when cloning a perforce repository
Date: Thu, 16 Jan 2014 17:02:18 +0100
Message-ID: <B6C98918-4339-4D14-8C52-4B3AEC2526E7@iwi.me>
References: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me> <20140114001820.GA12058@padd.com> <20140114232432.GA31465@padd.com> <843E4B24-5EDD-4451-8849-425160576A99@iwi.me> <20140116130833.GA15613@padd.com> <4FE5D5E6-60F6-4111-B538-5CA01092A2F0@iwi.me> <20140116144519.GB15674@padd.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexandru Juncu <alexj@rosedu.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 17:02:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3pOp-0005s3-Vn
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 17:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbaAPQC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 11:02:27 -0500
Received: from catkin.iwi.me ([91.121.49.159]:42051 "EHLO catkin.iwi.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbaAPQC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 11:02:26 -0500
Received: from imac-de-admin.private.4d.fr (unknown [194.98.194.79])
	(Authenticated sender: damien@iwi.me)
	by catkin.iwi.me (Postfix) with ESMTPSA id 5CC38A25E9;
	Thu, 16 Jan 2014 17:02:20 +0100 (CET)
In-Reply-To: <20140116144519.GB15674@padd.com>
X-Mailer: Apple Mail (2.1827)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240515>


On 16 Jan 2014, at 15:45, Pete Wyckoff <pw@padd.com> wrote:

> Oh cool, that helps a lot.  P4 is just broken here, so we can get
> away with being a bit sloppy in git.  I'll try just pretending
> "empty symlinks" are not in the repo.  Hopefully you'll have a
> future commit in your p4 repo that brings back bn.h properly.

Thanks !
I would love to use git instead of perforce if possible :)

> Still not sure about how I'll test this.

I can test for you, no probleme with that.


> 
> Thanks,
> 
> 		-- Pete
> 
