From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [COGITO PATCH] cg-branch-switch and local branches
Date: Thu, 02 Jun 2005 08:09:38 +0200
Message-ID: <87ekblthlp.fsf@gmail.com>
References: <87ekbmi5zl.fsf@ifae.es> <87mzqaqgv1.fsf@gmail.com>
	<877jheqcah.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 02 08:07:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddiqo-0005oC-V1
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 08:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVFBGJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 02:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVFBGJh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 02:09:37 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:61360 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261562AbVFBGJg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 02:09:36 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j5269YZ12621
	for <git@vger.kernel.org>; Thu, 2 Jun 2005 08:09:34 +0200
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <877jheqcah.fsf@gmail.com> (
 =?utf-8?q?Santi_B=C3=A9jar's_message_of?= "Wed, 01 Jun 2005 18:20:22
 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

        I have realized that it was overcomplicated and against the
        common practice of having .git/HEAD pointing to the current
        branch, as I've just seen on a git-switch-branch by Jeff.

        But the only thing I miss now is the origin handling.

        Sorry for the noise.

        Santi

