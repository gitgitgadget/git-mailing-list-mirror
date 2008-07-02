From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 21:36:55 +0200
Message-ID: <20080702193655.GB21297@leksak.fem-net>
References: <20080702182510.GC29559@glandium.org> <20080702183701.GE16235@cuci.nl> <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org> <20080702174255.GB16235@cuci.nl> <20080702182510.GC29559@glandium.org> <g4gho9$g42$1@ger.gmane.org> <20080702143519.GA8391@cuci.nl> <20080702193157.GA21297@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE89M-0001Od-8X
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 21:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYGBTg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 15:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYGBTg6
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 15:36:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:45606 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752218AbYGBTg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 15:36:58 -0400
Received: (qmail invoked by alias); 02 Jul 2008 19:36:56 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp034) with SMTP; 02 Jul 2008 21:36:56 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/759QQlxj7739HY6dFWXregifXW7W3MjtFMgyxRA
	Os7PfuA+EM9WT/
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KE88N-00067L-1o; Wed, 02 Jul 2008 21:36:55 +0200
Content-Disposition: inline
In-Reply-To: <20080702193157.GA21297@leksak.fem-net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87186>

A short typo fix:
> I wonder if grafts can be used in combination with sequencer in such a
> way that you rewrite foo~20000..foo~19950 and then fake the parents of
> foo~19949 to be the rewritten once.

s/once/ones/

To give it some sense. Sorry ;)

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
