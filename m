From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: testing vger handling of charsets (part 1)
Date: Tue, 15 May 2007 10:32:35 +0200
Message-ID: <20070515083235.GE9096@diana.vm.bytemark.co.uk>
References: <20070515test.1@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bfields@fieldses.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 10:32:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnsSk-0000Am-QB
	for gcvg-git@gmane.org; Tue, 15 May 2007 10:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580AbXEOIch convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 04:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757670AbXEOIch
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 04:32:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3662 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757628AbXEOIcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 04:32:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HnsSR-0002PR-00; Tue, 15 May 2007 09:32:35 +0100
Content-Disposition: inline
In-Reply-To: <20070515test.1@coredump.intra.peff.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47328>

On 2007-05-15 03:12:05 -0400, Jeff King wrote:

> This is a test message to check how vger reacts to seeing 8bit
> characters (like Hasselstr=C3=B6m) in a message without the right mim=
e
> header. Previous attempts were eaten by the list because of a lack
> of a message id.

This was broken when I got it via the list, but looked good when I got
it directly.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
