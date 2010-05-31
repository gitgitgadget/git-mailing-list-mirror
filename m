From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH] Update URL of parsecvs repository in documentation
Date: Mon, 31 May 2010 12:06:00 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483678617@xmail3.se.axis.com>
References: <20100530151211.GA19064@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Ralf Baechle <ralf@linux-mips.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 31 12:06:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ1sz-0000vl-ET
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 12:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab0EaKGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 06:06:13 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:37377 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab0EaKGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 06:06:12 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o4VA614M018695;
	Mon, 31 May 2010 12:06:01 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Mon, 31 May 2010 12:06:01 +0200
Thread-Topic: [PATCH] Update URL of parsecvs repository in documentation
Thread-Index: AcsACppeLwcvXr69Tri3kgAIE9+EswAnFrrA
In-Reply-To: <20100530151211.GA19064@linux-mips.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148036>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Ralf Baechle
> Sent: den 30 maj 2010 17:12
> To: git@vger.kernel.org
> Subject: [PATCH] Update URL of parsecvs repository in documentation
> 
> The parsecvs repository has moved.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  Documentation/git-cvsimport.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index 8bcd875..d38f8a8 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -215,7 +215,7 @@ want to import consider using these alternative tools which proved to be
>  more stable in practice:
> 
>  * cvs2git (part of cvs2svn), `http://cvs2svn.tigris.org`
> -* parsecvs, `http://cgit.freedesktop.org/~keithp/parsecvs`
> +* parsecvs, `git://anongit.freedesktop.org/git/users/keithp/repos/parsecvs.git/`
> 
>  Author
>  ------

The repository at 
git://anongit.freedesktop.org/git/users/keithp/repos/parsecvs.git/
lacks 32 commits made by Keith between 2006-09-10 and 2009-03-07 that 
were present in git://anongit.freedesktop.org/~keithp/parsecvs (which
I believe superseded http://cgit.freedesktop.org/~keithp/parsecvs).

I do not know if there is an official clone of parsecvs which contains
Keith's changes up till March 2009 at this time, though I have seen a 
couple of clones which contains various extra fixes.

//Peter
