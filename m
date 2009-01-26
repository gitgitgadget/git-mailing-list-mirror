From: Mike Hommey <mh@glandium.org>
Subject: Re: Translations [of Documentation] in Git release?
Date: Mon, 26 Jan 2009 17:23:51 +0100
Organization: glandium.org
Message-ID: <20090126162351.GA8911@glandium.org>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com> <m3hc3mxn9d.fsf@localhost.localdomain> <Pine.LNX.4.64.0901261426350.7798@ds9.cixit.se> <200901261631.18157.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Krefting <peter@softwolves.pp.se>, Dill <sarpulhu@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUHL-0007G4-2r
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbZAZQYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbZAZQYN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:24:13 -0500
Received: from vuizook.err.no ([85.19.221.46]:56731 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbZAZQYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 11:24:12 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LRUFo-0007Iu-No; Mon, 26 Jan 2009 17:24:07 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LRUFb-0002N3-O6; Mon, 26 Jan 2009 17:23:51 +0100
Content-Disposition: inline
In-Reply-To: <200901261631.18157.jnareb@gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107224>

On Mon, Jan 26, 2009 at 04:31:17PM +0100, Jakub Narebski wrote:
> On Mon, 26 Jan 2009, Peter Krefting wrote:
> > Jakub Narebski wrote:
> > 
> > > With GUI translations we just use gettext conventions. I don't know
> > > any such convention for docs:
> > 
> > There is a lot of documentation being translated using PO files. po4a -
> > http://po4a.alioth.debian.org/ - is a nice starting point for that.
> 
> I'm not sure if XLIFF wouldn't be better format to use to translate
> _documents_.  Gettext was meant to translate, I think, not very long
> messages in programs.
> 
> Also I am not sure how much support this idea has. True, in last Git
> User's Survey[1] 63% to 76% wanted (parts of) Documentation... but that
> was out of 325 people who answered this question, with 3236 responses
> to survey in total, so numbers are more like 6% - 8%.

On the other hand, the people who would really need the translations
didn't answer the survey at all, since they couldn't read it.

Mike
