From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 4/8] Don't split long and short description in "stg edit"
Date: Mon, 8 Oct 2007 08:41:42 +0200
Message-ID: <20071008064142.GA6170@diana.vm.bytemark.co.uk>
References: <20071007231446.12626.14259.stgit@yoghurt> <20071007231735.12626.81744.stgit@yoghurt> <20071007234009.GA19073@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 08:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IemK1-0007cl-Vm
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 08:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbXJHGmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 02:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbXJHGmY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 02:42:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2200 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbXJHGmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 02:42:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IemJC-0001d3-00; Mon, 08 Oct 2007 07:41:42 +0100
Content-Disposition: inline
In-Reply-To: <20071007234009.GA19073@old.davidb.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60296>

On 2007-10-07 16:40:10 -0700, David Brown wrote:

> On Mon, Oct 08, 2007 at 01:17:35AM +0200, Karl Hasselstr=F6m wrote:
>
> > "stg edit" used to present the patch information like this:
>
> I think this fix is better to begin with. I found it especially
> confusing when there was only a single line commit message. Now the
> header looks like a header :-)

Yes, that case was confusing too.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
