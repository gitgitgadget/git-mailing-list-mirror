From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: How to change merge message ("weenie commits")
Date: Thu, 25 Jan 2007 17:16:09 +0100
Message-ID: <20070125161609.GA7453@diana.vm.bytemark.co.uk>
References: <17848.54065.631799.755255@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 17:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA7Ho-0005jX-D7
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 17:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbXAYQQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 25 Jan 2007 11:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbXAYQQc
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 11:16:32 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2652 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030258AbXAYQQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 11:16:13 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HA7Gj-0001y0-00; Thu, 25 Jan 2007 16:16:09 +0000
Content-Disposition: inline
In-Reply-To: <17848.54065.631799.755255@lisa.zopyra.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37735>

On 2007-01-25 09:56:33 -0600, Bill Lear wrote:

> Do others run into this and perhaps have a good solution?

I make lots of small commits, then periodically rewrite history with
StGIT to get the nice-looking set of commits I wish I had made in the
first place. I don't think I do anything that couldn't be done with
just git, but StGIT is made precisely for this kind of work, and is
quite good at it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
