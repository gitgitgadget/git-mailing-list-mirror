From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: tig show <commit> not working anymore?
Date: Thu, 16 Sep 2010 13:56:24 -0500
Message-ID: <20100916185624.GJ5785@bowser.ece.utexas.edu>
References: <20100916125337.GG5785@bowser.ece.utexas.edu>
 <AANLkTimug6MC6iZvOu5b3g6rG=GeJiL5Fvnj4AD0ppWp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 20:56:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwJdL-0004w6-Ih
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 20:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab0IPS41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 14:56:27 -0400
Received: from irongate.mail.utexas.edu ([146.6.25.6]:3648 "EHLO
	irongate.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425Ab0IPS40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 14:56:26 -0400
X-IronPort-MID: 55230930
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAB4FkkyAU36G/2dsb2JhbACiDHHFXoVBBIRLNoUu
Received: from wb1-a.mail.utexas.edu ([128.83.126.134])
  by irongate.mail.utexas.edu with ESMTP; 16 Sep 2010 13:56:26 -0500
Received: (qmail 59293 invoked from network); 16 Sep 2010 18:56:25 -0000
Received: from bowser.ece.utexas.edu (a.kumar@146.6.33.245)
  by wb1.mail.utexas.edu with (RC4-SHA encrypted) ESMTPSSA; 16 Sep 2010 18:56:25 -0000
Content-Disposition: inline
In-Reply-To: <AANLkTimug6MC6iZvOu5b3g6rG=GeJiL5Fvnj4AD0ppWp@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156344>

Dear Jonas,

On Thu, Sep 16, 2010 at 09:47:58AM -0400, Jonas Fonseca wrote:
> On Thu, Sep 16, 2010 at 08:53, Kumar Appaiah <a.kumar@alumni.iitm.ac.in> wrote:
> > I observed that, since commit
> > 53c089443cd9885fa677becee4bf7ffd56c3c357, tig show <commit> doesn't
> > seem to work the same way as I had expected it to. The documentation
> > update doesn't seem to indicate that this was to be expected (or I
> > didn't understand it properly). Could someone please confirm that
> > tig show <commit> should actually do something similar to git show <commit> | tig ?
> 
> What is the expected behavoir that is not working anymore?

I expect the formatted commit diff of the commit I specify after
show. For example, tig show a74fa1900a65384bc4140fe45a55877bc981b185
used to show me the commit titled "Misc cleanups" (in tig), while now,
it shows me HEAD.

Please let me know if I have missed something.

Thanks!

Kumar
