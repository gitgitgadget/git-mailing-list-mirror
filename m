From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Fixed indeterminism in t2102-pull-policy-rebase
Date: Thu, 23 Aug 2007 09:52:24 +0200
Message-ID: <20070823075224.GA11772@diana.vm.bytemark.co.uk>
References: <11878521324048-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Aug 23 09:52:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO7Ug-0006mW-IB
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 09:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbXHWHwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755643AbXHWHwi
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 03:52:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3663 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990AbXHWHwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 03:52:38 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IO7UP-00035A-00; Thu, 23 Aug 2007 08:52:25 +0100
Content-Disposition: inline
In-Reply-To: <11878521324048-git-send-email-davidk@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56468>

On 2007-08-23 08:55:32 +0200, David K=E5gedal wrote:

> This test case was sometimes succeeding and sometimes failing. This
> seems to be how it was expected to work.

Oooh, evil.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
