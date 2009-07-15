From: Theodore Tso <tytso@mit.edu>
Subject: Re: Dividing up a large merge.
Date: Wed, 15 Jul 2009 12:07:46 -0400
Message-ID: <20090715160746.GI6570@mit.edu>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com> <20090715002926.GA26630@huya.quicinc.com> <20090715122828.GA6570@mit.edu> <m31voiuktb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davidb@quicinc.com, Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 18:07:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR71S-0004g7-5c
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 18:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbZGOQHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 12:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbZGOQHu
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 12:07:50 -0400
Received: from THUNK.ORG ([69.25.196.29]:46344 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755300AbZGOQHu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 12:07:50 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MR71H-0002oe-7N; Wed, 15 Jul 2009 12:07:47 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MR71G-0002U7-Ge; Wed, 15 Jul 2009 12:07:46 -0400
Content-Disposition: inline
In-Reply-To: <m31voiuktb.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123325>

On Wed, Jul 15, 2009 at 06:39:46AM -0700, Jakub Narebski wrote:
> Theodore Tso <tytso@mit.edu> writes:
> 
> > Yeah, that's another prime argument for maintaining your changes as a
> > patch queue.  I use a combination of quilt plus git.
> 
> Why not StGit, or Guilt, or TopGit?

Sorry, typo; that should have read "guilt".  The example workflow I
included used guilt commands.

					- Ted
