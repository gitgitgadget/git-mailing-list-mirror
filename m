From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: GNU patch: new 2.6 release
Date: Sat, 14 Nov 2009 11:17:29 +0100
Organization: SUSE Labs
Message-ID: <200911141117.29238.agruen@suse.de>
References: <200911140109.34202.agruen@suse.de> <6672d0160911140045h70243c12w3c56ad925dc70d39@mail.gmail.com>
Reply-To: bug-patch@gnu.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bug-patch@gnu.org
To: =?utf-8?q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 11:16:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Ffi-00057w-SY
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 11:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbZKNKPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2009 05:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbZKNKPk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 05:15:40 -0500
Received: from cantor.suse.de ([195.135.220.2]:55924 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587AbZKNKPk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 05:15:40 -0500
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3F9FC6CB00;
	Sat, 14 Nov 2009 11:15:43 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.1; i686; ; )
In-Reply-To: <6672d0160911140045h70243c12w3c56ad925dc70d39@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132865>

On Saturday 14 November 2009 09:45:11 am Bj=C3=B6rn Gustavsson wrote:
> Do you have any plans to support git-style binary patches?

Support for git's extended header lines for renames, copies, hashes, fi=
le=20
modes would be great. I'll happily take patches or eventually implement=
 it=20
myself. Binary patches are not as high on my wish list, but feel free t=
o send=20
code.

> That would be very useful in a workflow when you work in git (and hav=
e some
> binary files in the repository), but need to commit your finished wor=
k
> into another VCS (such as Clearcase).

Isn't there a better way to do this than with patches?

Thanks,
Andreas
