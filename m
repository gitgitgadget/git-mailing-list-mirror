From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC 1/2] sha1_file: close all pack files after running
Date: Mon, 5 Oct 2015 07:57:48 +0300
Message-ID: <20151005045748.GF26154@wheezy.local>
References: <1443670163-31193-1-git-send-email-max@max630.net>
 <1443670163-31193-2-git-send-email-max@max630.net>
 <33b74e875c7298f67640f5850e88c152@dscho.org>
 <763ac2b63d56d250e5e1a27f490f79db@dscho.org>
 <20151002192148.GD26154@wheezy.local>
 <21bd1c9c394a421bc06c6fa1837f16b6@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 06:57:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZixqX-00013L-JP
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 06:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbbJEE5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 00:57:53 -0400
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:34497
	"EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028AbbJEE5x (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 00:57:53 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-09.prod.phx3.secureserver.net with 
	id RGxo1r00A5B68XE01Gxrtw; Sun, 04 Oct 2015 21:57:52 -0700
Content-Disposition: inline
In-Reply-To: <21bd1c9c394a421bc06c6fa1837f16b6@dscho.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279036>

On Sun, Oct 04, 2015 at 04:53:30PM +0200, Johannes Schindelin wrote:
> I guess then we would need two different patches for the
> two different fixes, at least.
> 
> So now I am unsure how to proceed: I do not want to step
> on your toes, but I also want to see my use case fixed and
> I want to move forward on this. At the moment, it looks as
> if we are at an impasse.

Just continue with your patches then. I do not hurry.
