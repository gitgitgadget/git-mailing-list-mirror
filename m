From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Will git have a baseline feature or something alike?
Date: Fri, 29 Feb 2008 11:38:37 +0100
Message-ID: <20080229103837.GC14773@diana.vm.bytemark.co.uk>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com> <BAYC1-PASMTP1509BFBE329A906C583BDCAE140@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: eric miao <eric.y.miao@gmail.com>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Feb 29 11:39:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV2eL-00050K-CE
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 11:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbYB2Ki4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Feb 2008 05:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbYB2Kiz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 05:38:55 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4885 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbYB2Kiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 05:38:55 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JV2dR-0004Mh-00; Fri, 29 Feb 2008 10:38:37 +0000
Content-Disposition: inline
In-Reply-To: <BAYC1-PASMTP1509BFBE329A906C583BDCAE140@CEZ.ICE>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75520>

On 2008-02-29 04:56:09 -0500, Sean wrote:

> On Fri, 29 Feb 2008 17:23:37 +0800
>
> "eric miao" <eric.y.miao@gmail.com> wrote:
>
> > Yet I found the repository now grows to be 1.2G without checking
> > out anything. The checked out working tree of this is about 1.5G.
>
> There's something wrong in your setup, the entire kernel history
> should take less than 200M.

Try running "git gc".

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
