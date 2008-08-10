From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH v3 0/4] Teach git diff-tree --stdin to diff trees
Date: Sun, 10 Aug 2008 19:04:21 +0200
Message-ID: <20080810170421.GB28032@diana.vm.bytemark.co.uk>
References: <20080810153848.GA28032@diana.vm.bytemark.co.uk> <20080810161035.7116.2171.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 18:47:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSE43-0007TE-5M
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 18:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbYHJQpl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 12:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbYHJQpl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 12:45:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2393 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbYHJQpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 12:45:41 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KSEL7-0008QP-00; Sun, 10 Aug 2008 18:04:21 +0100
Content-Disposition: inline
In-Reply-To: <20080810161035.7116.2171.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91857>

On 2008-08-10 18:12:39 +0200, Karl Hasselstr=F6m wrote:

>       diff-tree: Note that the commit ID is printed with --stdin

BTW, I imagine this one might be maint material, if deemed acceptable.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
