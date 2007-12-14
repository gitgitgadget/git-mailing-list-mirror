From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 4/5] Make generic --message/--file/--save-template flags
Date: Fri, 14 Dec 2007 07:44:50 +0100
Message-ID: <20071214064450.GA10278@diana.vm.bytemark.co.uk>
References: <20071214062251.29148.86191.stgit@yoghurt> <20071214062521.29148.66456.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:45:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J34IT-0006MF-W4
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbXLNGo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbXLNGoz
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:44:55 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2077 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbXLNGoz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:44:55 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J34Hy-0002rb-00; Fri, 14 Dec 2007 06:44:50 +0000
Content-Disposition: inline
In-Reply-To: <20071214062521.29148.66456.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68248>

On 2007-12-14 07:25:21 +0100, Karl Hasselstr=F6m wrote:

> And let "stg edit" use them.

Nothing else in the "safe" branch uses this currently. But one of the
"experimental" patches I just sent out does.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
