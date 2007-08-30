From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/1] Add basic test for stg status
Date: Thu, 30 Aug 2007 14:07:55 +0200
Message-ID: <20070830120755.GA14181@diana.vm.bytemark.co.uk>
References: <11884722703161-git-send-email-davidk@lysator.liu.se> <87lkbtgtpy.fsf@morpheus.local> <87ir6xgssk.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Aug 30 14:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQioy-0003az-4E
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbXH3MIV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 30 Aug 2007 08:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbXH3MIU
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:08:20 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2943 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbXH3MIU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 08:08:20 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IQioV-0003iM-00; Thu, 30 Aug 2007 13:07:55 +0100
Content-Disposition: inline
In-Reply-To: <87ir6xgssk.fsf@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57030>

On 2007-08-30 13:34:19 +0200, David K=E5gedal wrote:

> David K=E5gedal <davidk@lysator.liu.se> writes:
>
> > David K=E5gedal <davidk@lysator.liu.se> writes:
> >
> > > Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
> >
> > This was probably confused by the fact that the patch itself
> > contained my name in latin1 encoding.
>
> Or not. It's the same problem as before. I'll stop using
> git-send-email until I or someone else fixes it.

Try "stg mail", since you are already using StGIT. It used to have
this kind of problem, but it doesn't anymore (at least for me).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
