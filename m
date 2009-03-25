From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] init-db: support --import to add all files and commit
 right after init
Date: Wed, 25 Mar 2009 04:51:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903250450240.10279@pacific.mpi-cbg.de>
References: <1237946996-5287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-791588615-1237953082=:10279"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:51:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmK8n-0008UR-Vk
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbZCYDtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 23:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbZCYDtS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:49:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:35722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754730AbZCYDtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 23:49:17 -0400
Received: (qmail invoked by alias); 25 Mar 2009 03:49:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 25 Mar 2009 04:49:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Pgw1HYcAPyz0L1nkhE1R2fIEU/gpn01ofSbLIlK
	A57Ndj3vLcdCuX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1237946996-5287-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114552>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-791588615-1237953082=:10279
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 25 Mar 2009, Nguyễn Thái Ngọc Duy wrote:

> This is equivalent to "git init;git add .;git commit -q -m blah".
> I find myself doing that too many times, hence this shortcut.
> 
> In future, --fast-import support would also be nice if the import
> directory has a lot of files.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

I wanted to have this for a _long_ time!

But could you please say "init" in the subject instead of "init-db"?  The 
latter is just a historical wart we have to carry around.

Thanks,
Dscho
--8323328-791588615-1237953082=:10279--
