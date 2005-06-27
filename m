From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Mon, 27 Jun 2005 17:53:12 -0400
Organization: me
Message-ID: <200506271753.13247.tomlins@cam.org>
References: <42B9E536.60704@pobox.com> <20050627194031.GK12006@waste.org> <20050627195134.GA17107@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@ucw.cz>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Mon Jun 27 23:46:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn1Qk-0001xb-7V
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 23:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVF0Vwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVF0Vwv
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 17:52:51 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:55498 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261841AbVF0Vwk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 17:52:40 -0400
Received: from grover (dsl-146-113.aei.ca [66.36.146.113])
	by aeimail.aei.ca (8.12.10/8.12.10) with ESMTP id j5RLqOdL005704;
	Mon, 27 Jun 2005 17:52:25 -0400 (EDT)
To: Benjamin LaHaise <bcrl@kvack.org>
User-Agent: KMail/1.8.1
In-Reply-To: <20050627195134.GA17107@kvack.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Monday 27 June 2005 15:51, Benjamin LaHaise wrote:
> On Mon, Jun 27, 2005 at 12:40:31PM -0700, Matt Mackall wrote:
> >  $ export PYTHONPATH=${HOME}/lib/python  # add this to your .bashrc
> 
> This needs to be ${HOME}/lib64/python on x86-64.

Be careful.  This is not true on debian.

Ed Tomlinson
