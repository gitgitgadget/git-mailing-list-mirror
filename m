From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git branch diagram
Date: Fri, 18 Apr 2008 08:46:55 +0200
Message-ID: <20080418064655.GA23209@diana.vm.bytemark.co.uk>
References: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Patrick.Higgins@cexp.com
X-From: git-owner@vger.kernel.org Fri Apr 18 08:48:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmkOH-0000dT-MG
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 08:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbYDRGrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2008 02:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbYDRGrF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 02:47:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1301 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbYDRGrE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 02:47:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JmkN6-00066r-00; Fri, 18 Apr 2008 07:46:56 +0100
Content-Disposition: inline
In-Reply-To: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79863>

On 2008-04-17 11:00:56 -0600, Patrick.Higgins@cexp.com wrote:

> I read in the stgit docs that developing directly in the master
> branch is discouraged by convention, but I don't really understand
> why. The git tutorial shows work happening directly in master, so I
> wasn't sure if that's a convention that only makes sense for stgit
> or for plain git, too.

It doesn't even make sense for StGit. The documentation on the StGit
homepage that claims this ("As a convention, you should avoid working
in the 'master' branch of a remote project and use it only as a
reference, since it reflects someone else's work.") is simply
horribly, horribly outdated.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
