From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Do not insert an empty line before the diffstat info
Date: Mon, 4 Aug 2008 16:20:00 +0200
Message-ID: <20080804142000.GC12232@diana.vm.bytemark.co.uk>
References: <20080731125010.894.84022.stgit@dawn.rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 15:59:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0aU-0004gj-6w
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 15:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbYHDN5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 09:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbYHDN5v
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 09:57:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4978 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbYHDN5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 09:57:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQ0um-0003Zf-00; Mon, 04 Aug 2008 15:20:00 +0100
Content-Disposition: inline
In-Reply-To: <20080731125010.894.84022.stgit@dawn.rfc1149.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91354>

On 2008-07-31 14:50:10 +0200, Samuel Tardieu wrote:

> To make the format of stg output closer to the plain git one, do not
> insert an empty line between the "---" separator and the diffstat
> information.

Thanks, will apply. (IMO it's slightly uglier, but it's better to be
consistent. And it does save some space.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
