From: Charles Bailey <charles@hashpling.org>
Subject: Re: in support of git pushing only the active branch by default
Date: Sun, 18 Mar 2012 08:53:47 +0000
Message-ID: <20120318085347.GA612@hashpling.org>
References: <5B1A6856-E87D-4AB6-B7CC-71055FF2DF48@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mark Essel <messel@me.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 10:00:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9By8-0000M3-4N
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 10:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976Ab2CRI75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 04:59:57 -0400
Received: from avasout04.plus.net ([212.159.14.19]:39461 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab2CRI74 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 04:59:56 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Mar 2012 04:59:56 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout04 with smtp
	id mwto1i0012iA9hg01wtpEl; Sun, 18 Mar 2012 08:53:49 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.0 cv=LITkseq9 c=1 sm=1 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=-GleFfVwiy8A:10 a=yvbpGxkJF8EA:10 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10
 a=kj9zAlcOel0A:10 a=rxt3RxhRpuc7yeePk4EA:9 a=CjuIK1q_8ugA:10
 a=wpJ/2au8Z6V/NgdivHIBow==:117
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1S9Bs4-0000JT-57; Sun, 18 Mar 2012 08:53:48 +0000
Content-Disposition: inline
In-Reply-To: <5B1A6856-E87D-4AB6-B7CC-71055FF2DF48@me.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193374>

On Sat, Mar 17, 2012 at 06:16:51AM -0400, Mark Essel wrote:
> I would appreciate a brief option to push all branches, git push-all or similar for personal git usage.

You mean like this?

git push origin :
