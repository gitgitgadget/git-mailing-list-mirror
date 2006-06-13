From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: cvs import error
Date: Mon, 12 Jun 2006 21:25:49 -0700
Message-ID: <20060613042549.GA8287@prophet.net-ronin.org>
References: <20060611234842.GA12713@prophet.net-ronin.org> <46a038f90606111731q34fe431fn36d751b387ab69a9@mail.gmail.com> <20060612035737.GA16580@prophet.net-ronin.org> <46a038f90606112101la88168xc5d540fe1220fbf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 13 06:26:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq0TS-0004MJ-JS
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 06:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbWFMEZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 00:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932864AbWFMEZv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 00:25:51 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:151 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S932823AbWFMEZv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 00:25:51 -0400
Received: from ramune by prophet.net-ronin.org with local (Exim 3.35 #1 (Debian))
	id 1Fq0TN-0002B4-00
	for <git@vger.kernel.org>; Mon, 12 Jun 2006 21:25:49 -0700
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90606112101la88168xc5d540fe1220fbf8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21762>

Whups, make an error on the reply so it didn't hit the list:

Switched to the git 'next' branch, applied that patch, nuked ~/.cvsps
(forgot it cached stuff), and rm'ing the one directory that was giving
cvsps fits (in that order) finally allowed the rest of the repo to get
imported.

Thanks!

-- DN
Daniel
