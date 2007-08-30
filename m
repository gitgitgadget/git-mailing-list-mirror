From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/2] Cleanup tree_status and use -z
Date: Thu, 30 Aug 2007 14:11:58 +0200
Message-ID: <20070830121158.GB14181@diana.vm.bytemark.co.uk>
References: <11884722703161-git-send-email-davidk@lysator.liu.se> <11884722703840-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin.marinas@gmail.com,
	David =?iso-8859-1?Q?K=E5gedal?= <david@virtutech.com>
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Aug 30 14:12:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQisj-0004ww-OM
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbXH3MMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 30 Aug 2007 08:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753656AbXH3MMM
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:12:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4033 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbXH3MML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 08:12:11 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IQisQ-0003jr-00; Thu, 30 Aug 2007 13:11:58 +0100
Content-Disposition: inline
In-Reply-To: <11884722703840-git-send-email-davidk@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57031>

On 2007-08-30 13:11:10 +0200, David K=E5gedal wrote:

> Improved the python code, eliminating temporary variables and using
> destructuring binds. And use NUL-separation instead of newlines.

Good changes, both of them. It all looks OK to me (but I haven't tried
to run it yet).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
