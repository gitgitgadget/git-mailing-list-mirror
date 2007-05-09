From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: FFmpeg considering GIT
Date: Wed, 9 May 2007 20:17:06 +0200
Organization: Dewire
Message-ID: <200705092017.06637.robin.rosenberg.lists@dewire.com>
References: <loom.20070502T111026-882@post.gmane.org> <17985.19926.347089.878721@cargo.ozlabs.ibm.com> <e5bfff550705082338p1a0c003lef230f96a3219ab8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Karl Hasselstr?m" <kha@treskal.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 20:17:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlqiu-0002VX-Bz
	for gcvg-git@gmane.org; Wed, 09 May 2007 20:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbXEISRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 14:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756613AbXEISRH
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 14:17:07 -0400
Received: from [83.140.172.130] ([83.140.172.130]:9570 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755699AbXEISRE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 14:17:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2C30D802802;
	Wed,  9 May 2007 20:10:55 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17647-07; Wed,  9 May 2007 20:10:54 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B2DB88027E7;
	Wed,  9 May 2007 20:10:54 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <e5bfff550705082338p1a0c003lef230f96a3219ab8@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46762>

onsdag 09 maj 2007 skrev Marco Costalba:
> On 5/9/07, Paul Mackerras <paulus@samba.org> wrote:
> > Marco Costalba writes:
> >
> > > Language to use is C++, not C (much more powerful IMHO)
> >
> > Sorry, C++ is not an option because I dislike it so much.
> 
> Well, speaking about GUI applications, the 90% is in the graphic
> library and only in small part in the language. With Qt we are at 95%
> 
> Anyhow does exist also python bindings for Qt.

Yes, there is package called PyQT (GPL) here:  http://www.riverbankcomputing.co.uk/pyqt/

There are bindings for most languages, even a Java binding.

-- robin
