From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-{diff,ls}-files from a subdirectory fails ...
Date: Wed, 24 Oct 2007 13:26:26 +0200
Message-ID: <20071024112626.GA6459@diana.vm.bytemark.co.uk>
References: <20071024012038.GA31326@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710241104560.25221@racer.site> <20071024104055.GB3908@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 13:26:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkeNq-00059j-BC
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 13:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbXJXL0e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2007 07:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbXJXL0e
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 07:26:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1057 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbXJXL0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 07:26:33 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IkeNW-0001gf-00; Wed, 24 Oct 2007 12:26:26 +0100
Content-Disposition: inline
In-Reply-To: <20071024104055.GB3908@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62209>

On 2007-10-24 12:40:55 +0200, Karl Hasselstr=F6m wrote:

> On 2007-10-24 11:06:43 +0100, Johannes Schindelin wrote:
>
> > IOW if you run git version v1.5.3.4-14-gdd5c8af or newer, you
> > should not experience this.
>
> Thanks for the pointer; that looks like it might indeed fix this
> bug. Will hopefully have time to verify later today.

It works! Very timely bugfix ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
