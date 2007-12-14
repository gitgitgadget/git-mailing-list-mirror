From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 5/5] Name the exit codes to improve legibility
Date: Fri, 14 Dec 2007 07:45:53 +0100
Message-ID: <20071214064553.GB10278@diana.vm.bytemark.co.uk>
References: <20071214062251.29148.86191.stgit@yoghurt> <20071214062527.29148.7928.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J34JP-0006Y5-Jn
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbXLNGp5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbXLNGp4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:45:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2080 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbXLNGp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:45:56 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J34Iz-0002tn-00; Fri, 14 Dec 2007 06:45:53 +0000
Content-Disposition: inline
In-Reply-To: <20071214062527.29148.7928.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68249>

On 2007-12-14 07:25:27 +0100, Karl Hasselstr=F6m wrote:

> +# Exit codes.
> +STGIT_SUCCESS =3D 0        # everything's OK
> +STGIT_GENERAL_ERROR =3D 1  # seems to be non-command-specific error
> +STGIT_COMMAND_ERROR =3D 2  # seems to be a command that failed

If anyone knows for sure, feel free to fix up these descriptions.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
