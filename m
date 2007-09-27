From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/2] "stg assimilate" on steroids
Date: Thu, 27 Sep 2007 07:48:33 +0200
Message-ID: <20070927054833.GA12207@diana.vm.bytemark.co.uk>
References: <20070926020911.1202.2580.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 07:48:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IamF5-0004h4-28
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 07:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbXI0Fsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 01:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbXI0Fsp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 01:48:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2222 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbXI0Fsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 01:48:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IamEj-0003D0-00; Thu, 27 Sep 2007 06:48:33 +0100
Content-Disposition: inline
In-Reply-To: <20070926020911.1202.2580.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59265>

On 2007-09-26 04:15:02 +0200, Karl Hasselstr=F6m wrote:

> If you have been using that, manually change the stack format
> version back to 2, and create empty "applied" and "unapplied" files,
> and run the new assimilate. That should fix it. I hope.

Not quite. You need this fix first.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
