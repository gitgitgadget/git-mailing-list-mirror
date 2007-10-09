From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 6/6] Let some commands work with detached HEAD
Date: Tue, 9 Oct 2007 07:12:47 +0200
Message-ID: <20071009051247.GA22750@diana.vm.bytemark.co.uk>
References: <20071008085430.9734.75797.stgit@yoghurt> <20071008085540.9734.60137.stgit@yoghurt> <20071008153450.GA12247@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 07:13:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If7Ox-0007dk-Np
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 07:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbXJIFMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 01:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbXJIFMy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 01:12:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3181 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbXJIFMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 01:12:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1If7Oh-000622-00; Tue, 09 Oct 2007 06:12:47 +0100
Content-Disposition: inline
In-Reply-To: <20071008153450.GA12247@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60358>

On 2007-10-08 17:34:50 +0200, Karl Hasselstr=F6m wrote:

> This hunk shouldn't be here, since diff does use crt_series. (The
> commit message also has to be modified accordingly.)

I've fixed the patch and pushed it out, along with the two new ones.
=46or good measure, I also demoted it from safe to experimental.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
