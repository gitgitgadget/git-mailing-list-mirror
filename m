From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: [PATCH 1/4] t5400: expect success for denying deletion
Date: Sun, 9 Nov 2008 11:38:41 +0100
Message-ID: <20081109113841.1382380a@perceptron>
References: <20081107220730.GA15942@coredump.intra.peff.net>
	<20081107220955.GA16058@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sam Vilain <sam@vilain.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 11:40:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kz7ir-0008T0-5e
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 11:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbYKIKj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 05:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbYKIKj3
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 05:39:29 -0500
Received: from zoidberg.org ([213.133.99.5]:48560 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbYKIKj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 05:39:29 -0500
Received: from perceptron (p54BB9E64.dip0.t-ipconnect.de [::ffff:84.187.158.100])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sun, 09 Nov 2008 11:39:23 +0100
  id 0015AFB2.4916BDDB.0000254A
In-Reply-To: <20081107220955.GA16058@coredump.intra.peff.net>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100438>

Hi,

On Fri, 7 Nov 2008 17:09:55 -0500, Jeff King <peff@peff.net> wrote:
> Reading over the mailing list postings which led to a240de11, I think
> it is simply a case that Jan didn't fully understand what
> expect_failure meant


Yes, that's exactly what happened, and it won't likely happen again.
Thanks for fixing and for the Cc.

-Jan
