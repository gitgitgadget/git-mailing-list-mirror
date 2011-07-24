From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Fwd: Help using git I'm review process
Date: Sun, 24 Jul 2011 17:40:14 +0200
Message-ID: <20110724154014.GA28962@jpl.local>
References: <245B4B40-CA0A-43F6-A3F0-85E50D75CB93@gmail.com>
 <CA+39Oz5OT_RjyGeQdKaFycHjwN6hzy+N6P6DDBAtSv3vTYo_4A@mail.gmail.com>
 <A5291838-E8F4-47DA-A3E7-E6CBFE7664C9@gmail.com>
 <CA+39Oz5V3sf0ODqtm+jn3=ob9qeSTkVierBcKaCuWXYkjfqobQ@mail.gmail.com>
 <E394E5A1-8F0E-47E6-AE69-A974655B2D13@gmail.com>
 <CA+39Oz4-+RmX0XqrW9o+uxGjTtP3grTUaaZ9FBHdR4GPh21ciw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Adam <thomas@xteddy.org>
To: Mathew Benson <mathew.benson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 18:03:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql190-0000QX-Sn
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 18:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab1GXQDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jul 2011 12:03:01 -0400
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:37728 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab1GXQDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 12:03:00 -0400
X-Greylist: delayed 1364 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jul 2011 12:03:00 EDT
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id F36C5EA9DA
	for <git@vger.kernel.org>; Sun, 24 Jul 2011 17:40:15 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqIiAC08LE5T46eEPGdsb2JhbAA1AQEEATgBJyUFDAxAEhQBEQsBDQsiF4kdjmSPUQsBAQEBNzKIfAK8LYVgXwScWYZ5
X-IronPort-AV: E=Sophos;i="4.67,257,1309730400"; 
   d="scan'208";a="208427758"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb2.telenor.se with ESMTP; 24 Jul 2011 17:40:15 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 9BD05422F5; Sun, 24 Jul 2011 17:40:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CA+39Oz4-+RmX0XqrW9o+uxGjTtP3grTUaaZ9FBHdR4GPh21ciw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177766>

On Sunday, July 24, 2011 at 14:58,
     Mathew Benson <mathew.benson@gmail.com> wrote:

> I know Gerrit integrates with Git.  Does it integrate with Trac?

That depends on what you mean by "Trac integration". Can you use Gerrit
and Trac together? Yes. Can Gerrit speak directly to a Trac server and
do stuff based on e.g. review events? No. Does Gerrit have interfaces
that would allow you to create glue that'll connect the two tools? Yes,
it might be possible depending on your answer to my first question.

> Gerrit does understand c/c++, right?

Gerrit does support syntax highlighting of several languages. Apart fro=
m
that it doesn't care about what language you write your code in.

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
