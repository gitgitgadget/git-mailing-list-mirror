From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGit] Can't compile under windows (MSVC2008)
Date: Tue, 23 Sep 2008 13:41:54 +0200
Message-ID: <48D8D602.7000309@lyx.org>
References: <gbak2u$v9b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 13:43:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki6Ii-0002og-2L
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 13:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbYIWLmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 07:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbYIWLmT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 07:42:19 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:41220 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbYIWLmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 07:42:18 -0400
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 896763EA0E1;
	Tue, 23 Sep 2008 13:42:11 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 3B3013EA0E4;
	Tue, 23 Sep 2008 13:42:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <gbak2u$v9b$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96551>

On 23/09/2008 13:31, Abdelrazak Younes wrote:
> Hello,
>
> I tried to follow README_WIN.txt:
>
> C:\devel\qgit\qgit4>qmake qgit.pro
>
> The Makefile (attached to this mail) seems to be correctly generated in
> the same directory (C:\devel\qgit\qgit4).
>
> Then, under MSVC2008 Express, I get this error:

Just wanted to add that command-line compilation with nmake was 
successful and a bin/qgit.exe was generated that seems to work correctly 
with latest Git-1.6.0.2-preview20080923 for Windows.

Thanks to all developers involved.

Abdel.
