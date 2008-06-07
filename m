From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 1/5] Rename Repository.head to Repository.head_ref
Date: Sat, 7 Jun 2008 11:09:51 +0200
Message-ID: <20080607090951.GC32647@diana.vm.bytemark.co.uk>
References: <20080606204322.8805.32313.stgit@localhost.localdomain> <20080606204537.8805.12051.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 11:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4uRm-00031o-CR
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 11:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbYFGJJ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 05:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbYFGJJ5
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 05:09:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4484 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYFGJJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 05:09:57 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K4uQp-0000J3-00; Sat, 07 Jun 2008 10:09:51 +0100
Content-Disposition: inline
In-Reply-To: <20080606204537.8805.12051.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84188>

On 2008-06-06 21:45:37 +0100, Catalin Marinas wrote:

> This is to avoid confusion with the Stack.head function which
> returns a commit object rather than a file name. The patch also
> changes the "new" function to use stack.head directly rather than
> via the Repository.refs... object.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
