From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Wed, 17 Oct 2007 18:10:55 +0200
Message-ID: <200710171810.56215.robin.rosenberg.lists@dewire.com>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <ee77f5c20710152307n48431a6eu5dc95ee504968e4e@mail.gmail.com> <856417h9cj.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "David Symonds" <dsymonds@gmail.com>,
	"Geert Bosch" <bosch@adacore.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	=?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	"Junio Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 18:10:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiBS2-00078A-Um
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 18:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935348AbXJQQI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 12:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935592AbXJQQI1
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 12:08:27 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3101 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1765576AbXJQQIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 12:08:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AFF09146E993;
	Wed, 17 Oct 2007 17:59:45 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13000-05; Wed, 17 Oct 2007 17:59:45 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 4B5FD82758E;
	Wed, 17 Oct 2007 17:59:45 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <856417h9cj.fsf@lola.goethe.zz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61388>

tisdag 16 oktober 2007 skrev David Kastrup:
> "David Symonds" <dsymonds@gmail.com> writes:
> 
> > On 16/10/2007, David Kastrup <dak@gnu.org> wrote:
> >> Geert Bosch <bosch@adacore.com> writes:
> >>
> >> > On Oct 15, 2007, at 13:53, David Symonds wrote:
> >> >> That's also why I suggested "skip"; you might not be able to test a
> >> >> particular commit, but you might also not *want* to test a particular
> >> >> commit for some reason.
> >> >
> >> > Skip seems a great choice: it directly expresses the wish to
> >> > not consider a certain commit. The reason is unimportant.
> >>
> >> But it is an _action_, while "good" and "bad" are properties.
> >
> > "skipped", then.
> 
> "good" and "bad" are descriptive.  "to be skipped" would be necessary
> to fit it.

Yet another very short word: void.

I'm thinking about ticket copies that sometimes are marked "void" so you cannot use it.

-- robin
