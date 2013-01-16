From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 0/7] guilt patches, including git 1.8 support
Date: Tue, 15 Jan 2013 22:26:06 -0500
Message-ID: <20130116032606.GA6052@thunk.org>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>,
	Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 04:26:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvJe9-0008NI-F5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 04:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583Ab3APD0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 22:26:17 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:43684 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757485Ab3APD0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 22:26:16 -0500
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1TvJdg-0003Db-5n; Wed, 16 Jan 2013 03:26:08 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id BD2CE2E99A0; Tue, 15 Jan 2013 22:26:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130116022606.GI12524@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213724>

On Tue, Jan 15, 2013 at 06:26:06PM -0800, Jonathan Nieder wrote:
> Hi Jeff and other guilty parties,
> 
> I collected all the guilt patches I could find on-list and added one
> of my own.  Completely untested, except for running the regression
> tests.  These are also available via git protocol from
> 
>   git://repo.or.cz/guilt/mob.git mob

Jonathan, thanks for collecting all of the guilt patches!  Your repro
was also very much really useful since I hadn't grabbed the latest
patches from jeffpc's repo before it disappeared after the kernel.org
security shutdown.  

Jeff, do you need some help getting your repro on kernel.org
re-established?

							- Ted
