From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] Documentation: Refer to git-commit-tree in git-filter-branch help
Date: Fri, 24 Sep 2010 10:12:44 -0600
Organization: icecavern.net
Message-ID: <201009241012.44861.wjl@icecavern.net>
References: <1284389994-16892-1-git-send-email-wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:13:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAtQ-0000h6-3j
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409Ab0IXQMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:12:54 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:51342 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932158Ab0IXQMx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:12:53 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id D8B4E36067;
	Fri, 24 Sep 2010 10:12:49 -0600 (MDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-trunk-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <1284389994-16892-1-git-send-email-wjl@icecavern.net>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157016>

On Monday, September 13, 2010 08:59:54 Wesley J. Landaker wrote:
> Currently, the help for git filter-branch refers users of --env-filter
> to git-commit for information about environment variables affecting
> commits. However, this information is not contained in the git-commit
> help, but is very explicitly detailed in git-commit-tree.

Was there something disagreeable about this patch, or did it just get lost? 

I'd like to help make it easier for others who might find themselves on a 
hunt for the right environment variables for --env-filter like I was.
