From: Johan Herland <johan@herland.net>
Subject: Re: [RFC?] Telling git about more complex relationships between commits (Was: Re: FFmpeg considering GIT)
Date: Fri, 4 May 2007 14:30:09 +0200
Message-ID: <200705041430.09405.johan@herland.net>
References: <loom.20070502T111026-882@post.gmane.org> <81b0412b0705040236w1d5f26bx8ac351ade2f4ea6a@mail.gmail.com> <200705041239.22300.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 14:30:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjwva-0008WS-Jz
	for gcvg-git@gmane.org; Fri, 04 May 2007 14:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbXEDMaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 08:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbXEDMaX
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 08:30:23 -0400
Received: from sam.opera.com ([213.236.208.81]:42099 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243AbXEDMaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 08:30:22 -0400
Received: from pc052.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l44CU92i011090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 May 2007 12:30:09 GMT
User-Agent: KMail/1.9.6
In-Reply-To: <200705041239.22300.andyparkins@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.90.1/3204/Thu May  3 18:46:39 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46177>

On Friday 04 May 2007, Andy Parkins wrote:
> As for custom headers - it's a great idea; here's the one that would be
> most useful:
>
>  X-Git-SVN-ID: 9553f0bf-9b14-0410-a0b8-cfaf0461ba5b
>
> That way git-svn wouldn't (necessarily) need to keep its .rev_db file, and
> it wouldn't need any special handling to allow the repository to be cloned.

That's _exactly_ the kind of use of this I'd like to see. Great example. :)


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
